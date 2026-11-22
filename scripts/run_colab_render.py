#!/usr/bin/env python3
"""
scripts/run_colab_render.py
---------------------------
Automated headless Google Colab CLI runner using `google-colab-cli` (`colab`).
Implements all verified guardrails from colab-cli SKILL.md:
  - Lightweight tarball bundling (~1.8 MB; excludes legacy 1 GB archives)
  - 3x retry loop on colab upload / startup colab exec WebSocket drops
  - Explicit --timeout (default 1800s; colab exec default is only 30s)
  - Remote tar.gz download (avoids colab download str(dict) JSON corruption)
  - Strict nbformat error + sentinel audit (Render sentinel: P5JS_COLAB_RENDER_COMPLETE)
  - Optional rclone sync to gdrive:Colab Notebooks/
  - Mandatory try/finally colab stop + active session verification
"""

from __future__ import annotations

import argparse
import base64
import shutil
import subprocess
import tarfile
import time
from pathlib import Path

import nbformat

REPO_ROOT = Path(__file__).resolve().parents[1]
CONDA_BIN = "/home/kaiser/.miniforge/bin/conda"
RCLONE_BIN = "/home/kaiser/.local/bin/rclone"
SENTINEL = "P5JS_COLAB_RENDER_COMPLETE"


def colab_cmd(*args: str, timeout: int = 180) -> subprocess.CompletedProcess[str]:
    if shutil.which("colab"):
        cmd = ["colab", *args]
    else:
        cmd = [CONDA_BIN, "run", "--no-capture-output", "-n", "num_python", "colab", *args]
    return subprocess.run(cmd, text=True, capture_output=True, timeout=timeout)


def run_with_retry(fn, label: str, attempts: int = 3, delay_s: int = 5):
    last_res = None
    for idx in range(1, attempts + 1):
        res = fn()
        last_res = res
        if res.returncode == 0:
            return res
        print(f"[colab-runner] {label} attempt {idx}/{attempts} failed (rc={res.returncode}): {res.stderr.strip() or res.stdout.strip()}")
        if idx < attempts:
            time.sleep(delay_s)
    raise RuntimeError(f"{label} failed after {attempts} attempts: {last_res.stderr if last_res else 'unknown'}")


def build_bundle(repo_root: Path, bundle_path: Path) -> Path:
    include_paths = [
        "package.json",
        "scripts/render_p5_node.js",
        "scripts/pde_to_p5_helper.py",
        "assets/fonts",
        "sketches/p5js",
    ]
    with tarfile.open(bundle_path, "w:gz") as tar:
        for rel in include_paths:
            full = repo_root / rel
            if full.exists():
                tar.add(full, arcname=rel)
    size_mb = bundle_path.stat().st_size / 1e6
    print(f"[colab-runner] Built lightweight bundle {bundle_path} ({size_mb:.2f} MB)")
    return bundle_path


def audit_notebook(nb_path: Path) -> list[str]:
    nb = nbformat.read(nb_path, as_version=4)
    errors = []
    stdout_chunks = []
    for idx, cell in enumerate(nb.cells):
        for out in cell.get("outputs", []):
            otype = out.get("output_type")
            if otype == "error":
                errors.append(f"Cell {idx}: {out.get('ename')}: {out.get('evalue')}")
            elif otype == "stream":
                stdout_chunks.append("".join(out.get("text", "")))
    if errors:
        raise RuntimeError("Colab notebook errors detected:\n" + "\n".join(errors))
    full_stdout = "\n".join(stdout_chunks)
    if SENTINEL not in full_stdout:
        raise RuntimeError(f"Completion sentinel '{SENTINEL}' missing from executed notebook stdout.")
    print(f"[colab-runner] Audit passed: 0 error cells, sentinel '{SENTINEL}' confirmed.")
    return stdout_chunks


def extract_embedded_pngs(nb_path: Path, out_dir: Path) -> list[Path]:
    out_dir.mkdir(parents=True, exist_ok=True)
    nb = nbformat.read(nb_path, as_version=4)
    saved = []
    for idx, cell in enumerate(nb.cells):
        for j, out in enumerate(cell.get("outputs", [])):
            png_b64 = out.get("data", {}).get("image/png")
            if png_b64:
                dest = out_dir / f"colab_cell{idx:02d}_{j}.png"
                dest.write_bytes(base64.b64decode(png_b64))
                saved.append(dest)
    return saved


def main() -> None:
    parser = argparse.ArgumentParser(description="Execute p5.js rendering notebook on Google Colab via colab CLI")
    parser.add_argument("--notebook", default="Render🎦p5js.ipynb", help="Notebook path relative to repo root or absolute")
    parser.add_argument("--sketch", default=None, help="Optional sketch path override passed via P5_SKETCH env")
    parser.add_argument("--session", default="p5js-poster-colab", help="Colab session name")
    parser.add_argument("--gpu", default="none", choices=["none", "T4", "L4", "A100"], help="Optional GPU tier")
    parser.add_argument("--timeout", type=int, default=1800, help="colab exec timeout seconds")
    parser.add_argument("--out-dir", default="outputs/posters", help="Local output directory")
    parser.add_argument("--sync-drive", action="store_true", help="Copy executed notebook to gdrive:Colab Notebooks/")
    args = parser.parse_args()

    nb_path = Path(args.notebook)
    if not nb_path.is_absolute():
        nb_path = (REPO_ROOT / nb_path).resolve()
    out_dir = Path(args.out_dir)
    if not out_dir.is_absolute():
        out_dir = (REPO_ROOT / out_dir).resolve()
    out_dir.mkdir(parents=True, exist_ok=True)

    bundle_path = Path("/tmp/p5js_colab_bundle.tar.gz")
    build_bundle(REPO_ROOT, bundle_path)

    exec_nb_out = nb_path.with_name(f"{nb_path.stem}_output{nb_path.suffix}")
    local_results_tar = Path("/tmp/p5js_colab_results.tar.gz")

    session_started = False
    try:
        new_args = ["new", "-s", args.session]
        if args.gpu != "none":
            new_args.extend(["--gpu", args.gpu])
        print(f"[colab-runner] Provisioning Colab session '{args.session}' (gpu={args.gpu})...")
        res = colab_cmd(*new_args, timeout=180)
        if res.returncode != 0:
            raise RuntimeError(f"colab new failed: {res.stderr or res.stdout}")
        session_started = True
        print(res.stdout.strip())

        print("[colab-runner] Uploading lightweight sketch bundle...")
        run_with_retry(
            lambda: colab_cmd("upload", "-s", args.session, str(bundle_path), "/content/p5js_colab_bundle.tar.gz", timeout=180),
            label="colab upload bundle",
        )

        exec_args = ["exec", "-s", args.session, "-f", str(nb_path), "--timeout", str(args.timeout)]
        if args.sketch:
            exec_args.extend(["--env", f"P5_SKETCH={args.sketch}"])
        print(f"[colab-runner] Executing {nb_path.name} remotely (timeout={args.timeout}s)...")
        exec_res = run_with_retry(
            lambda: colab_cmd(*exec_args, timeout=args.timeout + 120),
            label="colab exec notebook",
        )
        print(exec_res.stdout.strip())

        if not exec_nb_out.exists():
            raise FileNotFoundError(f"Expected executed output notebook at {exec_nb_out}")

        audit_notebook(exec_nb_out)

        # Download packaged outputs tarball (prevents colab_cli str(dict) corruption on JSON/ipynb)
        dl_res = run_with_retry(
            lambda: colab_cmd("download", "-s", args.session, "/content/colab_render_outputs.tar.gz", str(local_results_tar), timeout=180),
            label="colab download results tarball",
        )
        print(dl_res.stdout.strip())

        if local_results_tar.exists():
            with tarfile.open(local_results_tar, "r:gz") as tar:
                tar.extractall(out_dir)
            print(f"[colab-runner] Extracted Colab render artifacts into {out_dir}")

        if args.sync_drive and Path(RCLONE_BIN).exists():
            drive_target = "gdrive:Colab Notebooks/Render_p5js_Colab.ipynb"
            subprocess.run(
                [RCLONE_BIN, "copyto", str(exec_nb_out), drive_target, "--drive-use-trash=false"],
                check=True,
            )
            print(f"[colab-runner] Synced executed notebook to {drive_target}")

    finally:
        if session_started:
            print(f"[colab-runner] Stopping Colab session '{args.session}'...")
            stop_res = colab_cmd("stop", "-s", args.session, timeout=120)
            print((stop_res.stdout or stop_res.stderr).strip())
        sess_res = colab_cmd("sessions", timeout=60)
        print("[colab-runner] Active sessions after teardown:")
        print(sess_res.stdout.strip())


if __name__ == "__main__":
    main()
