#!/usr/bin/env python3
"""
scripts/pde_to_p5_helper.py
---------------------------
Offline Processing (.pde) -> p5.js (.js) transpiler scaffold replacing the
defunct pde2js.herokuapp.com web converter.

Translates common Processing 3 constructs:
  - void setup()/draw()/helper() -> function ...
  - float/int/boolean/String/color/PFont/PImage declarations -> let
  - size(w, h) -> createCanvas(w, h) with optional --max-width downscaling
  - loadFont("...vlw") -> web-safe / bundled "Inter" fallback
  - save("foo.tif") -> saveCanvas("foo", "png")
  - println(...) -> console.log(...)
  - Optional Node/browser dual-mode instance wrapper
"""

from __future__ import annotations

import argparse
import re
from pathlib import Path


def _extract_size(src: str) -> tuple[int, int] | None:
    m = re.search(r"\bsize\s*\(\s*(\d+)\s*,\s*(\d+)(?:\s*,\s*\w+)?\s*\)\s*;", src)
    if not m:
        return None
    return int(m.group(1)), int(m.group(2))


def transpile_pde_to_p5(src: str, *, mode: str = "global", max_width: int = 1920) -> str:
    notes: list[str] = []
    out = src

    # Normalize CRLF
    out = out.replace("\r\n", "\n")

    # Compute optional scale factor if original canvas exceeds max_width (e.g. 7860x4320 8K sketches)
    dims = _extract_size(out)
    if dims and max_width > 0 and dims[0] > max_width:
        scale = max_width / dims[0]
        new_w = round(dims[0] * scale)
        new_h = round(dims[1] * scale)
        out = re.sub(
            r"\bsize\s*\(\s*\d+\s*,\s*\d+(\s*,\s*\w+)?\s*\)\s*;",
            lambda m: f"createCanvas({new_w}, {new_h}); // scaled from {dims[0]}x{dims[1]}",
            out,
            count=1,
        )
        notes.append(f"Downscaled canvas from {dims[0]}x{dims[1]} -> {new_w}x{new_h} (--max-width {max_width})")
    else:
        out = re.sub(
            r"\bsize\s*\(\s*([^,;]+)\s*,\s*([^,;)]+)(?:\s*,\s*(P2D|P3D|JAVA2D|FX2D))?\s*\)\s*;",
            lambda m: (
                f"createCanvas({m.group(1).strip()}, {m.group(2).strip()}"
                + (", WEBGL);" if m.group(3) == "P3D" else ");")
            ),
            out,
        )

    # Function return types -> function
    out = re.sub(
        r"(?m)^(\s*)(?:public\s+|private\s+|protected\s+)?(?:void|int|float|double|boolean|String|color)\s+([A-Za-z_]\w*\s*\([^)]*\)\s*\{?)",
        r"\1function \2",
        out,
    )

    # Type casts (int)(x) / (float)x -> Math.trunc / Number
    out = re.sub(r"\(\s*int\s*\)\s*\(", "Math.trunc(", out)
    out = re.sub(r"\(\s*float\s*\)\s*", "", out)
    out = re.sub(r"\b(\d+\.\d+|\d+\.)f\b", r"\1", out)

    # Variable declarations (excluding for-loop handled below)
    type_kw = r"(?:final\s+)?(?:float|int|double|boolean|String|color|PFont|PImage|char)"
    out = re.sub(rf"\bfor\s*\(\s*{type_kw}\s+", "for (let ", out)
    out = re.sub(rf"(?m)^(\s*){type_kw}\s+", r"\1let ", out)

    # Processing helpers -> p5.js equivalents
    out = re.sub(r"\bprintln\s*\(", "console.log(", out)
    out = re.sub(r"\bsmooth\s*\(\s*\d*\s*\)\s*;", "smooth();", out)
    out = re.sub(
        r'\bloadFont\s*\(\s*"([^"]+)"\s*\)',
        r'"Inter" /* TODO: was loadFont("\1") */',
        out,
    )
    out = re.sub(
        r'\bsave\s*\(\s*"([^"]+?)\.(tif|tiff|png|jpg|jpeg)"\s*\)\s*;',
        lambda m: f'saveCanvas("{m.group(1)}", "png"); // originally .{m.group(2)}',
        out,
        flags=re.IGNORECASE,
    )
    out = re.sub(
        r"\bloadStrings\s*\(",
        "/* TODO: supply data asset */ loadStrings(",
        out,
    )

    # Warn if loadImage or P3D/VideoExport detected
    if "loadImage(" in out:
        notes.append("Contains loadImage(): ensure asset paths are placed in sketch data/ or preloaded in preload().")
    if "VideoExport" in out or "GifMaker" in out:
        notes.append("Contains Java VideoExport/GifMaker: export frames via scripts/render_p5_node.js --frames N --mp4 out.mp4.")
    if "textFont(" in out:
        notes.append("Replaced .vlw bitmap fonts with 'Inter' fallback.")

    header_lines = [
        "// Auto-scaffolded from Processing (.pde) by scripts/pde_to_p5_helper.py",
    ]
    for n in notes:
        header_lines.append(f"// NOTE: {n}")
    header = "\n".join(header_lines) + "\n\n"

    if mode == "global":
        return header + out

    # Instance mode wrapper for scripts/render_p5_node.js
    indented = "\n".join("  " + line if line else "" for line in out.splitlines())
    return (
        header
        + "module.exports = function createSketch(p, cfg = {}) {\n"
        + "  // Note: instance-mode scaffold; prefix bare p5 globals with `p.` as needed during review.\n"
        + indented
        + "\n};\n"
    )


def main() -> None:
    parser = argparse.ArgumentParser(description="Offline Processing (.pde) -> p5.js (.js) converter")
    parser.add_argument("--input", required=True, help="Input .pde file path")
    parser.add_argument("--output", required=True, help="Output .js file path")
    parser.add_argument("--mode", choices=["global", "instance"], default="global", help="Target p5.js style")
    parser.add_argument("--max-width", type=int, default=1920, help="Scale down canvases wider than N px (0=disable)")
    args = parser.parse_args()

    in_path = Path(args.input)
    out_path = Path(args.output)
    out_path.parent.mkdir(parents=True, exist_ok=True)

    pde_src = in_path.read_text(encoding="utf-8", errors="replace")
    p5_src = transpile_pde_to_p5(pde_src, mode=args.mode, max_width=args.max_width)
    out_path.write_text(p5_src, encoding="utf-8")
    print(f"Converted {in_path} -> {out_path} (mode={args.mode}, {len(p5_src)} bytes)")


if __name__ == "__main__":
    main()
