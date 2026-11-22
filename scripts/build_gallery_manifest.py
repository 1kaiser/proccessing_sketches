#!/usr/bin/env python3
"""
scripts/build_gallery_manifest.py
---------------------------------
Builds `gallery_manifest.json` for the interactive GitHub Pages carousel and
Pattern Map from `git ls-tree` (sparse-checkout safe, zero large binary clone
required), mapping multi-MB archive PNGs to smaller sibling JPG previews where
available and linking every render back to its `.pde` or `.js` source.
"""

from __future__ import annotations

import argparse
import json
import os
import subprocess
from pathlib import Path
from urllib.parse import quote

REPO_ROOT = Path(__file__).resolve().parents[1]
RAW_BASE = "https://raw.githubusercontent.com/1kaiser/proccessing_sketches/main/"
BLOB_BASE = "https://github.com/1kaiser/proccessing_sketches/blob/main/"


def encode_repo_url(base: str, rel_posix: str) -> str:
    return base + "/".join(quote(part, safe="") for part in rel_posix.split("/"))


def list_tree_blobs(repo_root: Path) -> dict[str, int]:
    blobs: dict[str, int] = {}
    if (repo_root / ".git").exists():
        try:
            out = subprocess.check_output(
                ["git", "-C", str(repo_root), "ls-tree", "-r", "-l", "HEAD"],
                text=True,
            )
            for line in out.splitlines():
                if not line.strip():
                    continue
                meta, path = line.split("\t", 1)
                parts = meta.split()
                size = int(parts[3]) if len(parts) >= 4 and parts[3].isdigit() else 0
                blobs[path] = size
            return blobs
        except subprocess.CalledProcessError:
            pass

    for root, dirs, files in os.walk(repo_root):
        dirs[:] = [d for d in dirs if d not in (".git", "_site", "node_modules")]
        for fn in files:
            p = Path(root) / fn
            blobs[p.relative_to(repo_root).as_posix()] = p.stat().st_size
    return blobs


def classify_category(rel_path: str) -> tuple[str, str]:
    parts = Path(rel_path).parts
    if len(parts) >= 4 and parts[2] == "rendered_archive":
        folder = parts[3]
    else:
        folder = Path(rel_path).parent.name
    fl = folder.lower()
    if fl.startswith("colors"):
        return folder, "Colors & Lattices"
    if fl.startswith("rotating_arc") or fl.startswith("ro"):
        return folder, "Rotating Arcs"
    if fl.startswith("log_spiral") or fl == "lo":
        return folder, "Log Spirals"
    if fl.startswith("connection"):
        return folder, "Connections"
    if fl.startswith("element"):
        return folder, "Elements"
    return folder, "Fireworkx & Studies"


def find_pde_source(rel_path: str, pdes: list[str], pde_by_stem: dict[str, str]) -> str | None:
    p = Path(rel_path)
    same_dir = p.parent.as_posix()
    for cand in pdes:
        if Path(cand).parent.as_posix() == same_dir:
            return cand
    if p.parent.name.lower() == "data" and p.parent.parent != p.parent:
        parent_dir = p.parent.parent.as_posix()
        for cand in pdes:
            if Path(cand).parent.as_posix() == parent_dir:
                return cand
    folder_key = p.parent.name.lower()
    if folder_key == "data":
        folder_key = p.parent.parent.name.lower()
    if folder_key in pde_by_stem:
        return pde_by_stem[folder_key]
    stem_key = p.stem.lower()
    if stem_key in pde_by_stem:
        return pde_by_stem[stem_key]
    return None


def find_smaller_jpg_sibling(rel_path: str, blobs: dict[str, int]) -> str | None:
    stem_path = os.path.splitext(rel_path)[0]
    png_size = blobs.get(rel_path, 0)
    for ext in (".jpg", ".jpeg", ".JPG", ".JPEG"):
        cand = stem_path + ext
        if cand in blobs and (png_size == 0 or blobs[cand] < png_size):
            return cand
    return None


def build_manifest(repo_root: Path) -> dict:
    blobs = list_tree_blobs(repo_root)
    pdes = sorted(p for p in blobs if p.lower().endswith(".pde"))
    pde_by_stem: dict[str, str] = {}
    for p in pdes:
        stem = Path(p).stem.lower()
        pde_by_stem.setdefault(stem, p)
        parent = Path(p).parent.name.lower()
        if parent not in ("legacy_all_projects", "fireworkx", "rendered_archive"):
            pde_by_stem.setdefault(parent, p)

    archive_pngs = sorted(
        (
            p for p in blobs
            if p.lower().endswith(".png")
            and (
                p.startswith("sketches/processing/rendered_archive/")
                or p.startswith("sketches/processing/fireworkx/")
            )
        ),
        key=lambda s: (classify_category(s)[0].lower(), Path(s).name.lower()),
    )
    archive_gifs = sorted(
        p for p in blobs
        if p.lower().endswith(".gif")
        and (
            p.startswith("sketches/processing/rendered_archive/")
            or p.startswith("sketches/processing/fireworkx/")
        )
    )

    used_slugs: set[str] = {"featured-jax-xla-tpu-poster"}
    items: list[dict] = [
        {
            "id": "featured-jax-xla-tpu-poster",
            "slug": "featured-jax-xla-tpu-poster",
            "title": "JAX / XLA / TPU — Procedural p5.js Poster (2400×3200)",
            "folder": "jax_xla_tpu_poster",
            "category": "Featured",
            "previewUrl": "./assets/jax_xla_tpu_poster_p5_colab.png",
            "fullUrl": "./assets/jax_xla_tpu_poster_p5_colab.png",
            "sourceUrl": encode_repo_url(BLOB_BASE, "sketches/p5js/jax_xla_tpu_poster/sketch.js"),
            "sourceLabel": "sketches/p5js/jax_xla_tpu_poster/sketch.js",
            "repoPath": "outputs/posters/jax_xla_tpu_poster_p5_colab.png",
            "sizeBytes": blobs.get("outputs/posters/jax_xla_tpu_poster_p5_colab.png", 0),
            "mediaType": "png",
            "featured": True,
            "optInOnly": False,
            "optimizedPreview": False,
            "description": (
                "Deterministic 2400×3200 render synthesizing 6 Processing 3 archive patterns "
                "with 0.0000 pixel diff between local Node.js (Rust Skia) and Google Colab CLI."
            ),
        }
    ]

    optimized_count = 0
    matched_pde_count = 0

    for rel in archive_pngs:
        folder, category = classify_category(rel)
        base_slug = folder
        slug = base_slug
        n = 2
        while slug in used_slugs:
            slug = f"{base_slug}-{n}"
            n += 1
        used_slugs.add(slug)

        full_url = encode_repo_url(RAW_BASE, rel)
        jpg_sib = find_smaller_jpg_sibling(rel, blobs)
        if jpg_sib:
            preview_url = encode_repo_url(RAW_BASE, jpg_sib)
            optimized_preview = True
            optimized_count += 1
        else:
            preview_url = full_url
            optimized_preview = False

        pde_path = find_pde_source(rel, pdes, pde_by_stem)
        if pde_path:
            matched_pde_count += 1

        size_bytes = blobs.get(rel, 0)
        preview_bytes = blobs.get(jpg_sib, size_bytes) if jpg_sib else size_bytes

        items.append({
            "id": slug,
            "slug": slug,
            "title": f"{folder} — {Path(rel).name}",
            "folder": folder,
            "category": category,
            "previewUrl": preview_url,
            "fullUrl": full_url,
            "sourceUrl": encode_repo_url(BLOB_BASE, pde_path) if pde_path else None,
            "sourceLabel": pde_path,
            "repoPath": rel,
            "sizeBytes": size_bytes,
            "previewSizeBytes": preview_bytes,
            "mediaType": "png",
            "featured": False,
            "optInOnly": False,
            "optimizedPreview": optimized_preview,
            "description": f"Processing 3 output render archived under {folder} ({Path(rel).name}).",
        })

    for rel in archive_gifs:
        folder, _ = classify_category(rel)
        slug = f"{folder}-gif"
        n = 2
        while slug in used_slugs:
            slug = f"{folder}-gif-{n}"
            n += 1
        used_slugs.add(slug)

        pde_path = find_pde_source(rel, pdes, pde_by_stem)
        size_bytes = blobs.get(rel, 0)
        items.append({
            "id": slug,
            "slug": slug,
            "title": f"{folder} — {Path(rel).name} (Animation)",
            "folder": folder,
            "category": "Animations (GIF)",
            "previewUrl": encode_repo_url(RAW_BASE, rel),
            "fullUrl": encode_repo_url(RAW_BASE, rel),
            "sourceUrl": encode_repo_url(BLOB_BASE, pde_path) if pde_path else None,
            "sourceLabel": pde_path,
            "repoPath": rel,
            "sizeBytes": size_bytes,
            "previewSizeBytes": size_bytes,
            "mediaType": "gif",
            "featured": False,
            "optInOnly": True,
            "optimizedPreview": False,
            "description": f"Recorded Processing 3 animation GIF ({size_bytes / 1048576:.1f} MB) from {folder}.",
        })

    pattern_map = [
        {
            "id": "quadrant-lattice",
            "layer": "Quadrant Lattice & Dots",
            "targetSlug": "colors49",
            "pde": "colors49.pde & colors52.pde",
            "summary": "Four-quadrant coordinate sweep, +/× ticks, radial lerpColor fade & concentric orbits",
        },
        {
            "id": "diagonal-weave",
            "layer": "45° Diagonal Weave & Halo",
            "targetSlug": "colors48_4",
            "pde": "colors48_4.pde & rotating_arc_4_linesbool2bn.pde",
            "summary": "Symmetric ±45° lerpColor weave clipped inside a warm-cream (#FAF2DE) halo",
        },
        {
            "id": "triad-orbs",
            "layer": "Volumetric Open-Arc Triad",
            "targetSlug": "colors49",
            "pde": "colors49.pde xx()",
            "summary": "Layered filled open-arc gradient spheres representing the JAX → XLA → TPU stack",
        },
        {
            "id": "spectral-collar",
            "layer": "6-Sector Spectral Collar",
            "targetSlug": "colors52",
            "pde": "colors52.pde ab() & sine_6new1.pde",
            "summary": "Piecewise 6-sector RGB PIE spectrum collar paired with damped sine axis bridge",
        },
        {
            "id": "log-spiral",
            "layer": "Log-Spiral Lotus",
            "targetSlug": "log_spiraltestING12",
            "pde": "log_spiraltestING12.pde petals()",
            "summary": "12-fold a·exp(b·t) logarithmic spiral lotus & 48-point perimeter orbital halo",
        },
        {
            "id": "radial-spikes",
            "layer": "Radial Shaded Spikes",
            "targetSlug": "rotating_arc_anc_spikesent11",
            "pde": "rotating_arc_anc_spikesent11.pde",
            "summary": "36-fold 3-layer shaded quad() starburst core surrounding the inner focus ring",
        },
    ]

    slug_set = {it["slug"] for it in items}
    missing = [pm["targetSlug"] for pm in pattern_map if pm["targetSlug"] not in slug_set]
    if missing:
        raise RuntimeError(f"Pattern map targets missing from manifest: {missing}")

    return {
        "repo": "1kaiser/proccessing_sketches",
        "counts": {
            "total": len(items),
            "defaultCarousel": sum(1 for it in items if not it["optInOnly"]),
            "featured": 1,
            "archivePngs": len(archive_pngs),
            "gifs": len(archive_gifs),
            "optimizedPreviews": optimized_count,
            "matchedPdeSources": matched_pde_count,
        },
        "patternMap": pattern_map,
        "items": items,
    }


def main() -> None:
    parser = argparse.ArgumentParser(description="Build gallery_manifest.json for GitHub Pages carousel")
    parser.add_argument("--repo-root", default=str(REPO_ROOT), help="Repository root path")
    parser.add_argument("--out", default="site/gallery_manifest.json", help="Output JSON path")
    args = parser.parse_args()

    repo_root = Path(args.repo_root).resolve()
    out_path = Path(args.out)
    if not out_path.is_absolute():
        out_path = repo_root / out_path
    out_path.parent.mkdir(parents=True, exist_ok=True)

    manifest = build_manifest(repo_root)
    out_path.write_text(json.dumps(manifest, indent=2) + "\n", encoding="utf-8")
    c = manifest["counts"]
    print(
        f"Wrote {out_path}: {c['total']} items "
        f"({c['featured']} featured + {c['archivePngs']} archive PNGs + {c['gifs']} GIFs, "
        f"{c['matchedPdeSources']}/{c['archivePngs']} matched .pde, "
        f"{c['optimizedPreviews']} JPG previews)"
    )


if __name__ == "__main__":
    main()
