#!/usr/bin/env python3
"""
scripts/build_gallery_readme.py
-------------------------------
Portable replacement for quick_editor.ipynb's hardcoded README table updater.
Discovers rendered PNG thumbnails across outputs/posters/ and
sketches/processing/rendered_archive/ (via git ls-tree so sparse partial clones
are supported cleanly, plus filesystem fallback) and updates README.md between
<!-- GALLERY:START --> and <!-- GALLERY:END --> markers.
"""

from __future__ import annotations

import argparse
import re
import subprocess
from pathlib import Path
from urllib.parse import quote

REPO_ROOT = Path(__file__).resolve().parents[1]
GALLERY_START = "<!-- GALLERY:START -->"
GALLERY_END = "<!-- GALLERY:END -->"


def _url_path(rel_posix: str) -> str:
    return "/".join(quote(part) for part in rel_posix.split("/"))


def discover_gallery_images(repo_root: Path, include_posters: bool = False) -> list[str]:
    candidates: set[str] = set()

    # 1. Local files (optionally outputs/posters plus checked-out archive directories)
    search_bases = [
        repo_root / "sketches" / "processing" / "rendered_archive",
        repo_root / "sketches" / "processing" / "fireworkx",
    ]
    if include_posters:
        search_bases.insert(0, repo_root / "outputs" / "posters")

    for base in search_bases:
        if base.exists():
            for p in base.rglob("*"):
                if p.is_file() and p.suffix.lower() == ".png":
                    candidates.add(p.relative_to(repo_root).as_posix())

    # 2. Git tree entries (supports sparse blobless clones without downloading 1 GB of legacy assets)
    if (repo_root / ".git").exists():
        try:
            out = subprocess.check_output(
                [
                    "git", "-C", str(repo_root),
                    "ls-tree", "-r", "--name-only", "HEAD",
                    "sketches/processing/rendered_archive",
                    "sketches/processing/fireworkx",
                ],
                text=True,
            )
            for line in out.splitlines():
                rel = line.strip()
                if rel.lower().endswith(".png"):
                    candidates.add(rel)
        except subprocess.CalledProcessError:
            pass

    # Prioritize new posters first, then sort legacy archive naturally by folder/file
    posters = sorted(p for p in candidates if p.startswith("outputs/posters/"))
    legacy = sorted(
        (p for p in candidates if not p.startswith("outputs/posters/")),
        key=lambda s: (Path(s).parent.name.lower(), Path(s).name.lower()),
    )
    return posters + legacy


def format_markdown_gallery(paths: list[str], cols: int = 3) -> str:
    if not paths:
        return "_No PNG gallery assets indexed yet._"
    lines = [
        "| Preview | Preview | Preview |",
        "| :---: | :---: | :---: |",
    ]
    for i in range(0, len(paths), cols):
        row = paths[i : i + cols]
        cells = []
        for p in row:
            label = Path(p).parent.name if "rendered_archive" in p else Path(p).stem
            cells.append(f"![{label}]({_url_path(p)})")
        while len(cells) < cols:
            cells.append("")
        lines.append("| " + " | ".join(cells) + " |")
    return "\n".join(lines)


def update_readme(readme_path: Path, gallery_md: str) -> None:
    content = readme_path.read_text(encoding="utf-8")
    block = f"{GALLERY_START}\n{gallery_md}\n{GALLERY_END}"
    pattern = re.compile(re.escape(GALLERY_START) + r"[\s\S]*?" + re.escape(GALLERY_END))
    if pattern.search(content):
        updated = pattern.sub(lambda _: block, content, count=1)
    else:
        updated = content.rstrip() + "\n\n" + block + "\n"
    readme_path.write_text(updated, encoding="utf-8")


def main() -> None:
    parser = argparse.ArgumentParser(description="Rebuild README.md visual gallery table")
    parser.add_argument("--repo-root", default=str(REPO_ROOT), help="Repository root path")
    parser.add_argument("--readme", default="README.md", help="README path relative to repo root")
    parser.add_argument("--cols", type=int, default=3, help="Gallery columns")
    parser.add_argument("--include-posters", action="store_true", help="Include outputs/posters/ alongside archive renders")
    parser.add_argument("--dry-run", action="store_true", help="Print count only without modifying README")
    args = parser.parse_args()

    root = Path(args.repo_root).resolve()
    images = discover_gallery_images(root, include_posters=args.include_posters)
    gallery_md = format_markdown_gallery(images, cols=args.cols)
    if args.dry_run:
        print(f"Discovered {len(images)} PNG gallery entries.")
        return

    readme = root / args.readme
    update_readme(readme, gallery_md)
    print(f"Updated {readme} with {len(images)} PNG gallery entries.")


if __name__ == "__main__":
    main()
