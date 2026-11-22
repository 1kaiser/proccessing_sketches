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
# <a href="https://colab.research.google.com/github/1kaiser/proccessing_sketches/blob/main/notebooks/Processing_PDE_Batch_Colab.ipynb" target="_parent"><img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open In Colab"/></a>
#
# # Processing `.pde` Archive Inspector, Offline `p5.js` Converter & Gallery Builder
#
# > Portable replacement for `quick_editor.ipynb`: audits legacy Processing 3 sketches under `sketches/processing/`, transpiles `.pde` files offline into `p5.js` scaffolds without relying on defunct `pde2js.herokuapp.com`, and refreshes `README.md` galleries automatically.
#
# <details>
# <summary><b>Workflow Overview & Headless Processing 4 CLI Recipe (Click to expand)</b></summary>
#
# - **Dynamic Repo Resolution**: Automatically finds the project root locally or clones sparse `.pde` sources in Google Colab.
# - **Offline Transpilation**: Runs `scripts/pde_to_p5_helper.py` to turn Processing Java sketches into `p5.js` scaffolds with optional `7860×4320 -> 1920×1080` downscaling.
# - **Native Processing 4 Headless Execution**: Includes a shell recipe (`processing-java` + `xvfb-run`) for running Java `.pde` sketches directly on Ubuntu/Colab VMs.
#
# </details>

# %% tags=["parameters"]
SAMPLE_SKETCHES = ["dots.pde", "log_spiraltestING12.pde", "colors48_4.pde"]  # @param {type:"raw"}
MAX_WIDTH = 1920  # @param {type:"integer"}
CONVERT_ALL = False  # @param {type:"boolean"}
UPDATE_README = False  # @param {type:"boolean"}

# %% [markdown]
# ## Section 1: Repository Root & Legacy `.pde` Inventory
#
# > Counts all Processing 3 sketches and archived output folders cleanly across sparse or full clones.

# %%
import os
import subprocess
import sys
from pathlib import Path

IN_COLAB = ("google.colab" in sys.modules) or Path("/content").exists()
CWD = Path(".").resolve()

if (CWD / "scripts" / "pde_to_p5_helper.py").exists():
    REPO_ROOT = CWD
elif (CWD.parent / "scripts" / "pde_to_p5_helper.py").exists():
    REPO_ROOT = CWD.parent
elif IN_COLAB:
    REPO_ROOT = Path("/content/proccessing_sketches")
    if not REPO_ROOT.exists():
        subprocess.run(
            [
                "git", "clone", "--depth", "1", "--filter=blob:none", "--sparse",
                "https://github.com/1kaiser/proccessing_sketches.git", str(REPO_ROOT),
            ],
            check=True,
        )
        subprocess.run(
            ["git", "-C", str(REPO_ROOT), "sparse-checkout", "set", "--cone", "scripts", "sketches/processing/legacy_all_projects"],
            check=True,
        )
else:
    raise FileNotFoundError("Cannot locate scripts/pde_to_p5_helper.py from working directory.")

os.chdir(REPO_ROOT)
legacy_dir = REPO_ROOT / "sketches" / "processing" / "legacy_all_projects"
pde_files = sorted(legacy_dir.glob("*.pde"))
print(f"[inventory] REPO_ROOT={REPO_ROOT}")
print(f"[inventory] Legacy .pde sketches in sketches/processing/legacy_all_projects/: {len(pde_files)}")

# %% [markdown]
# ## Section 2: Offline `.pde` → `p5.js` Batch Transpilation (`pde_to_p5_helper.py`)
#
# > Replaces the defunct `pde2js.herokuapp.com` web service with deterministic offline transpilation into `outputs/tmp/converted_p5/`.

# %%
out_dir = REPO_ROOT / "outputs" / "tmp" / "converted_p5"
out_dir.mkdir(parents=True, exist_ok=True)

targets = pde_files if CONVERT_ALL else [legacy_dir / name for name in SAMPLE_SKETCHES if (legacy_dir / name).exists()]
converted = []
for pde in targets:
    dest = out_dir / f"{pde.stem}.js"
    subprocess.run(
        [
            sys.executable,
            "scripts/pde_to_p5_helper.py",
            "--input", str(pde),
            "--output", str(dest),
            "--max-width", str(MAX_WIDTH),
        ],
        cwd=REPO_ROOT,
        check=True,
    )
    converted.append(dest)

print(f"[convert] Generated {len(converted)} p5.js scaffolds in {out_dir}")
for item in converted[:3]:
    lines = item.read_text(encoding="utf-8", errors="replace").splitlines()[:12]
    print(f"\n--- Preview: {item.name} ---")
    print("\n".join(lines))

# %% [markdown]
# ## Section 3: Portable Gallery Discovery & `README.md` Updater
#
# > Discovers PNG renders via both local directories and `git ls-tree` (supporting sparse clones) and updates `README.md` when `UPDATE_README=True`.

# %%
gallery_cmd = [sys.executable, "scripts/build_gallery_readme.py"]
if not UPDATE_README:
    gallery_cmd.append("--dry-run")

res = subprocess.run(gallery_cmd, cwd=REPO_ROOT, text=True, capture_output=True, check=True)
print(res.stdout.strip())

# %% [markdown]
# ## Section 4: Optional Native Processing 4 Headless Linux / Colab CLI Recipe
#
# <details>
# <summary><b>Running Unmodified Java `.pde` Sketches Headlessly on Colab (Click to expand)</b></summary>
#
# ```bash
# # Download Processing 4 Linux x64 once inside Colab / Linux:
# apt-get update -qq && apt-get install -y -qq xvfb
# curl -sL https://github.com/processing/processing4/releases/download/processing-1293-4.3/processing-4.3-linux-x64.tgz | tar -xz -C /opt
# xvfb-run -a /opt/processing-4.3/processing-java \
#   --sketch=/content/proccessing_sketches/sketches/processing/legacy_all_projects/dots \
#   --run
# ```
#
# </details>
