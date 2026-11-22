# ---
# jupyter:
#   jupytext:
#     formats: py:percent,ipynb
#     text_representation:
#       extension: .py
#       format_name: percent
#       format_version: '1.3'
#   kernelspec:
#     display_name: Python 3
#     language: python
#     name: python3
# ---

# %% [markdown]
# <a href="https://colab.research.google.com/github/1kaiser/proccessing_sketches/blob/main/Render%F0%9F%8E%A6p5js.ipynb" target="_parent"><img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open In Colab"/></a>
#
# # Pure Node.js `p5.js` Headless Renderer (Local, Papermill & Google Colab CLI)
#
# > Executes `p5.js` (`v1.11.3`) sketches headlessly via Pure Node.js + `@napi-rs/canvas` (Rust Skia) + `jsdom` with zero browser overhead, supporting deterministic 2D high-resolution posters (`2400×3200`), multi-frame `ffmpeg` video exports, and automated `google-colab-cli` (`colab exec`) workflows.
#
# <details>
# <summary><b>Architecture & Colab CLI Guardrails (Click to expand)</b></summary>
#
# - **Zero-Browser Skia Pipeline**: Replaces legacy Selenium/Chromium `editor.p5js.org` UI typing with `scripts/render_p5_node.js` (`p5@1.11.3` + `@napi-rs/canvas` + `jsdom` + bundled `Inter` fonts).
# - **Dual Execution Support**: Works identically when launched via `colab exec -f Render🎦p5js.ipynb`, interactively via Google Colab's GitHub badge, or locally via `papermill`.
# - **Artifact Packaging**: Packs outputs into `/content/colab_render_outputs.tar.gz` to avoid `colab download` single-quoted `str(dict)` corruption and emits `P5JS_COLAB_RENDER_COMPLETE` upon verification.
#
# </details>

# %% tags=["parameters"]
SKETCH_PATH = "sketches/p5js/jax_xla_tpu_poster/sketch.js"  # @param {type:"string"}
WIDTH = 2400  # @param {type:"integer"}
HEIGHT = 3200  # @param {type:"integer"}
FRAMES = 1  # @param {type:"integer"}
FPS = 30  # @param {type:"integer"}
SEED = 2026  # @param {type:"integer"}
OUTPUT_NAME = "jax_xla_tpu_poster_p5_colab"  # @param {type:"string"}
SYNC_TO_DRIVE = False  # @param {type:"boolean"}

# %% [markdown]
# ## Section 1: Runtime Detection & Bootstrap
#
# > Resolves the repository root cleanly across local workspaces and ephemeral `/content` Colab runtimes, unpacks uploaded bundles (or clones sparse assets from GitHub when opened standalone), and verifies Node.js Skia dependencies.

# %%
import os
import shutil
import subprocess
import sys
import tarfile
from pathlib import Path

# Allow CLI callers via `colab exec --env P5_SKETCH=...` to override defaults cleanly
SKETCH_PATH = os.environ.get("P5_SKETCH", SKETCH_PATH)
WIDTH = int(os.environ.get("P5_WIDTH", WIDTH))
HEIGHT = int(os.environ.get("P5_HEIGHT", HEIGHT))
FRAMES = int(os.environ.get("P5_FRAMES", FRAMES))
FPS = int(os.environ.get("P5_FPS", FPS))
SEED = int(os.environ.get("P5_SEED", SEED))
OUTPUT_NAME = os.environ.get("P5_OUTPUT_NAME", OUTPUT_NAME)

IN_COLAB = ("google.colab" in sys.modules) or Path("/content").exists()
CWD = Path(".").resolve()

if (CWD / "scripts" / "render_p5_node.js").exists():
    WORK_ROOT = CWD
elif (CWD.parent / "scripts" / "render_p5_node.js").exists():
    WORK_ROOT = CWD.parent
elif IN_COLAB:
    WORK_ROOT = Path("/content/work")
    WORK_ROOT.mkdir(parents=True, exist_ok=True)
    bundle = Path("/content/p5js_colab_bundle.tar.gz")
    if bundle.exists():
        with tarfile.open(bundle, "r:gz") as tar:
            tar.extractall(WORK_ROOT)
        print(f"[bootstrap] Extracted uploaded bundle into {WORK_ROOT}")
    elif not (WORK_ROOT / "scripts" / "render_p5_node.js").exists():
        print("[bootstrap] Cloning sparse repo from GitHub...")
        subprocess.run(
            [
                "git", "clone", "--depth", "1", "--filter=blob:none", "--sparse",
                "https://github.com/1kaiser/proccessing_sketches.git", str(WORK_ROOT),
            ],
            check=True,
        )
        subprocess.run(
            ["git", "-C", str(WORK_ROOT), "sparse-checkout", "set", "--cone", "scripts", "assets", "sketches/p5js"],
            check=True,
        )
else:
    raise FileNotFoundError("Could not locate scripts/render_p5_node.js from current working directory.")

os.chdir(WORK_ROOT)
print(f"[runtime] IN_COLAB={IN_COLAB} | WORK_ROOT={WORK_ROOT} | Node={subprocess.check_output(['node', '-v'], text=True).strip()}")

# Verify or install Node.js p5 + Rust Skia + jsdom runtime
probe_js = 'require("@napi-rs/canvas"); require("jsdom"); require.resolve("p5"); console.log("NODE_RUNTIME_READY")'
probe = subprocess.run(
    ["node", "-e", probe_js],
    cwd=WORK_ROOT,
    capture_output=True,
    text=True,
)
if probe.returncode != 0:
    print("[bootstrap] Installing Node dependencies (p5, @napi-rs/canvas, jsdom)...")
    subprocess.run(["npm", "install", "--no-audit", "--no-fund"], cwd=WORK_ROOT, check=True)
    probe = subprocess.run(
        ["node", "-e", probe_js],
        cwd=WORK_ROOT,
        capture_output=True,
        text=True,
        check=True,
    )
print(probe.stdout.strip())

# %% [markdown]
# ## Section 2: Headless `p5.js` Render Execution
#
# > Executes `scripts/render_p5_node.js` to produce the target PNG poster (and optional MP4/GIF video when `FRAMES > 1`), then validates image dimensions and non-blank content.

# %%
from PIL import Image
import numpy as np

out_png = WORK_ROOT / "outputs" / "posters" / f"{OUTPUT_NAME}.png"
out_png.parent.mkdir(parents=True, exist_ok=True)
out_mp4 = WORK_ROOT / "outputs" / f"{OUTPUT_NAME}.mp4"

cmd = [
    "node",
    "scripts/render_p5_node.js",
    "--sketch", SKETCH_PATH,
    "--width", str(WIDTH),
    "--height", str(HEIGHT),
    "--frames", str(FRAMES),
    "--fps", str(FPS),
    "--seed", str(SEED),
    "--out", str(out_png),
]
if FRAMES > 1:
    cmd.extend(["--mp4", str(out_mp4)])

res = subprocess.run(cmd, cwd=WORK_ROOT, text=True, capture_output=True, check=True)
print(res.stdout.strip())
if res.stderr.strip():
    print(res.stderr.strip())

assert out_png.exists() and out_png.stat().st_size > 10_000, f"Output PNG missing or too small: {out_png}"
im = Image.open(out_png)
arr = np.asarray(im.convert("RGB"))
assert im.size == (WIDTH, HEIGHT), f"Expected {(WIDTH, HEIGHT)}, got {im.size}"
assert arr.std() > 5.0, "Rendered image appears nearly blank!"
print(f"[verify] Rendered {out_png.name}: {im.size} | {out_png.stat().st_size / 1e6:.2f} MB | rgb_std={arr.std():.2f}")

# %% [markdown]
# ## Section 3: Inline Preview & Tarball Artifact Packaging
#
# > Displays a crisp preview thumbnail inline and bundles full-resolution artifacts into `/content/colab_render_outputs.tar.gz` for reliable headless download via `colab download`.

# %%
import io
from IPython.display import Image as IPyImage, display

preview_im = im.convert("RGB")
preview_im.thumbnail((900, 1200), Image.Resampling.LANCZOS)
buf = io.BytesIO()
preview_im.save(buf, format="JPEG", quality=92)
display(IPyImage(data=buf.getvalue()))

archive_path = Path("/content/colab_render_outputs.tar.gz") if IN_COLAB else (WORK_ROOT / "outputs" / "colab_render_outputs.tar.gz")
archive_path.parent.mkdir(parents=True, exist_ok=True)
with tarfile.open(archive_path, "w:gz") as tar:
    tar.add(out_png, arcname=out_png.name)
    if FRAMES > 1 and out_mp4.exists():
        tar.add(out_mp4, arcname=out_mp4.name)

print(f"[package] Archive ready: {archive_path} ({archive_path.stat().st_size / 1e6:.2f} MB)")
print("P5JS_COLAB_RENDER_COMPLETE")

# %% [markdown]
# ## Section 4: Optional Google Drive Export & WebGL (`p5.brush`) Notes
#
# <details>
# <summary><b>Modern Google Drive Sync & Browser/WebGL Fallback Guide (Click to expand)</b></summary>
#
# 1. **Google Drive Export**: Replaces deprecated `gshell` with `google.colab.drive.mount('/content/drive')` in interactive Colab sessions or `rclone copyto` locally.
# 2. **Browser / `p5.brush` WebGL Sketches**: For WebGL-only community add-ons such as `p5.brush`, open `sketches/p5js/jax_xla_tpu_poster/index.html` in Chrome or use `puppeteer-core` with `--no-sandbox --headless=new`.
#
# </details>

# %%
if SYNC_TO_DRIVE and IN_COLAB:
    from google.colab import drive  # type: ignore

    drive.mount("/content/drive")
    drive_dir = Path("/content/drive/MyDrive/p5js_renders")
    drive_dir.mkdir(parents=True, exist_ok=True)
    shutil.copy2(out_png, drive_dir / out_png.name)
    print(f"[drive] Copied {out_png.name} -> {drive_dir}")
else:
    print("[drive] SYNC_TO_DRIVE=False; skipped interactive Drive mount.")
