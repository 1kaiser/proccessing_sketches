<div align="center">
  <img width="54" src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Processing_2021_logo.svg/360px-Processing_2021_logo.svg.png" alt="Processing Logo" />
  <h1>proccessing_sketches</h1>
  <p><strong>Generative Processing 3 archives &amp; headless <code>p5.js</code> rendering locally and via Google Colab CLI (<code>colab</code>)</strong></p>
  <p>
    <a href="https://colab.research.google.com/github/1kaiser/proccessing_sketches/blob/main/Render%F0%9F%8E%A6p5js.ipynb" target="_parent">
      <img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open Render🎦p5js in Colab" />
    </a>
    <a href="https://colab.research.google.com/github/1kaiser/proccessing_sketches/blob/main/notebooks/Processing_PDE_Batch_Colab.ipynb" target="_parent">
      <img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open PDE Batch Converter in Colab" />
    </a>
  </p>
</div>

---

## Featured Output: `JAX / XLA / TPU` Generative Poster (`p5.js` + Rust Skia)

<div align="center">
  <a href="outputs/posters/jax_xla_tpu_poster_p5_colab.png">
    <img src="outputs/posters/jax_xla_tpu_poster_p5_colab.png" width="460" alt="JAX XLA TPU Procedural p5.js Poster" />
  </a>
  <p><em><code>2400 × 3200</code> deterministic render produced identically on local Node.js (<code>0.85 s</code>) and Google Colab via <code>google-colab-cli</code> (<code>1.53 s</code>, <code>0.0000</code> mean pixel diff).</em></p>
</div>

Source sketch: [`sketches/p5js/jax_xla_tpu_poster/sketch.js`](sketches/p5js/jax_xla_tpu_poster/sketch.js) (interactive browser page: [`index.html`](sketches/p5js/jax_xla_tpu_poster/index.html)) synthesizing six core Processing 3 patterns from this repository:

| Poster Layer | Source Pattern in Archive | Formulation |
| :--- | :--- | :--- |
| **Quadrant Lattice & Dots** | [`colors49.pde`](sketches/processing/legacy_all_projects/colors49.pde) & [`colors52.pde`](sketches/processing/legacy_all_projects/colors52.pde) | `quadrants()`, `plus_cross()`, radial `lerpColor()` fade & concentric `dots()` orbits |
| **45° Diagonal Weave & Halo** | [`colors48_4.pde`](sketches/processing/legacy_all_projects/colors48_4.pde) & [`rotating_arc_4_linesbool2bn.pde`](sketches/processing/legacy_all_projects/rotating_arc_4_linesbool2bn.pde) | Symmetric ±45° `lerpColor` cross-hatch clipped inside a warm-cream (`#FAF2DE`) radial halo |
| **Volumetric Open-Arc Triad** | [`colors49.pde`](sketches/processing/legacy_all_projects/colors49.pde) `xx()` | Layered filled open-arc spheres (`for n = 180..0`) representing the JAX → XLA → TPU stack |
| **6-Sector Spectral Collar** | [`colors52.pde`](sketches/processing/legacy_all_projects/colors52.pde) `ab()` & [`sine_6new1.pde`](sketches/processing/legacy_all_projects/sine_6new1.pde) | Piecewise 6-phase RGB `PIE` spectrum + dual counter-sweeping open arc & sine bridge |
| **Log-Spiral Lotus & Spikes** | [`log_spiraltestING12.pde`](sketches/processing/legacy_all_projects/log_spiraltestING12.pde) `petals()` & [`rotating_arc_anc_spikesent11.pde`](sketches/processing/legacy_all_projects/rotating_arc_anc_spikesent11.pde) | 12-fold $a e^{b t}$ spiral lotus + 36-fold 3-layer shaded spike `quad()` core |
| **3×3 Character Grid & Colophon** | [`log_spiraltestING12.pde`](sketches/processing/legacy_all_projects/log_spiraltestING12.pde) & [`colors49.pde`](sketches/processing/legacy_all_projects/colors49.pde) | Nested `sentence.charAt(no)` 3×3 `"JAXXLATPU"` grid kissed by the warm halo + fade rule |

---

## Quickstart: Local, Google Colab CLI (`colab`) & Offline `.pde` Transpilation

### 1. Render `p5.js` Headlessly in Pure Node.js (No Browser Required)
```bash
npm install
npm run render:poster   # 2400x3200 PNG -> outputs/posters/jax_xla_tpu_poster_p5_local.png
npm run render:boids    # 90-frame MP4 -> outputs/flocking_boids_demo.mp4
```

### 2. Execute Remotely on Google Colab via `google-colab-cli`
```bash
python scripts/run_colab_render.py \
  --notebook notebooks/Render_p5js_Colab.ipynb \
  --session p5js-poster-colab \
  --out-dir outputs/posters \
  --timeout 1800
```
`scripts/run_colab_render.py` provisions the Colab VM, uploads a lightweight `~0.74 MB` bundle (scripts, fonts, and `sketches/p5js/` — skipping the `~1 GB` legacy archive), executes the notebook via `colab exec`, verifies zero cell errors and the `P5JS_COLAB_RENDER_COMPLETE` sentinel, downloads `/content/colab_render_outputs.tar.gz`, and stops the Colab session cleanly.

### 3. Convert Legacy Processing `.pde` Files Offline (Replaces Dead `pde2js.herokuapp.com`)
```bash
python scripts/pde_to_p5_helper.py \
  --input sketches/processing/legacy_all_projects/log_spiraltestING12.pde \
  --output outputs/tmp/log_spiraltestING12.js \
  --max-width 1920
```

---

## Repository Structure & Archive Notes

```text
proccessing_sketches/
├── README.md
├── Render🎦p5js.ipynb                    # Root Colab-badge entry (synced from notebooks/Render_p5js_Colab.py)
├── quick_editor.ipynb                    # Root PDE batch entry (synced from notebooks/Processing_PDE_Batch_Colab.py)
├── package.json                          # p5@1.11.3 + @napi-rs/canvas + jsdom headless runtime
├── assets/fonts/                         # Bundled SIL OFL Inter fonts for deterministic typography
├── notebooks/
│   ├── Render_p5js_Colab.{py,ipynb}      # Jupytext-paired dual Papermill/Colab renderer notebook
│   └── Processing_PDE_Batch_Colab.{py,ipynb}
├── scripts/
│   ├── render_p5_node.js                 # Pure Node.js p5.js + Skia + ffmpeg CLI renderer
│   ├── run_colab_render.py               # Automated google-colab-cli (colab) runner & verifier
│   ├── pde_to_p5_helper.py               # Offline Processing 3 -> p5.js transpiler scaffold
│   └── build_gallery_readme.py           # Portable gallery indexer (sparse-clone safe)
├── sketches/
│   ├── p5js/
│   │   ├── jax_xla_tpu_poster/           # Flagship 2400x3200 generative poster + index.html
│   │   └── flocking_boids/               # Modernized 2D Boids animation sketch + index.html
│   └── processing/
│       ├── legacy_all_projects/          # 208 original Processing 3 .pde sources (formerly AllProjects/)
│       ├── fireworkx/                    # Fireworkx P3D source & renders (formerly Fireworkx/)
│       └── rendered_archive/             # Historical sketch folders & renders (formerly test/)
└── outputs/posters/                      # Verified local & Colab p5.js poster outputs
```

> **Storage Audit Note**: All historical assets under `sketches/processing/rendered_archive/` are preserved intact with zero deletions (`git mv` / lossless index moves). Note that 62 legacy `.tif`/`.tiff` files totaling `~697 MB` remain inside that archive (plus `~145 MB` of historical `.gif`/`.mp4` renders) and can be cloned cleanly via `git clone --filter=blob:none --sparse` without downloading gigabytes of historical binaries.

---

## Historical Milestones & Gallery

- Early experiments (2013-09-24): [`dots.pde`](sketches/processing/legacy_all_projects/dots.pde)
- Radial & spiral studies (2015-09-22): [`colors48_4.pde`](sketches/processing/legacy_all_projects/colors48_4.pde)

### Rendered Gallery (Auto-Indexed via `scripts/build_gallery_readme.py`)

<!-- GALLERY:START -->
| Preview | Preview | Preview |
| :---: | :---: | :---: |
| ![jax_xla_tpu_poster_p5_colab](outputs/posters/jax_xla_tpu_poster_p5_colab.png) | ![jax_xla_tpu_poster_p5_local](outputs/posters/jax_xla_tpu_poster_p5_local.png) | ![ag](sketches/processing/rendered_archive/ag/diagonal11.png) |
| ![colors1](sketches/processing/rendered_archive/colors1/diagonal5.png) | ![colors10](sketches/processing/rendered_archive/colors10/diagonal6.png) | ![colors11](sketches/processing/rendered_archive/colors11/diagonal7.PNG) |
| ![colors12](sketches/processing/rendered_archive/colors12/diagonalc%20%281%29.png) | ![colors13](sketches/processing/rendered_archive/colors13/diagonalc%20kk%284%29.png) | ![colors14](sketches/processing/rendered_archive/colors14/diagonalck%20%285%29.png) |
| ![colors15](sketches/processing/rendered_archive/colors15/diagonalck%20%281%29.png) | ![colors16](sketches/processing/rendered_archive/colors16/diagonalck%20%281%29.png) | ![colors17](sketches/processing/rendered_archive/colors17/diagonalck%20%281%29.png) |
| ![colors18](sketches/processing/rendered_archive/colors18/diagonalck%20%281%29.png) | ![colors19](sketches/processing/rendered_archive/colors19/diagonalck%20%281%29.png) | ![colors2](sketches/processing/rendered_archive/colors2/diagonal5.png) |
| ![colors20](sketches/processing/rendered_archive/colors20/diagonalck%20%281%29.png) | ![colors21](sketches/processing/rendered_archive/colors21/diagonalck%20%281%29.png) | ![colors22](sketches/processing/rendered_archive/colors22/diagonalck%20%284%29.png) |
| ![colors23](sketches/processing/rendered_archive/colors23/diagonalck%20%285%29.png) | ![colors24](sketches/processing/rendered_archive/colors24/diagonalck%20%287%29.png) | ![colors25](sketches/processing/rendered_archive/colors25/diagonalck%20%287%29.png) |
| ![colors26](sketches/processing/rendered_archive/colors26/diagonalck%20%285%29.png) | ![colors27](sketches/processing/rendered_archive/colors27/diagonalck%20%285%29.png) | ![colors28](sketches/processing/rendered_archive/colors28/diagonalck%20%285%29.png) |
| ![colors29](sketches/processing/rendered_archive/colors29/diagonalck%20%285%29.png) | ![colors3](sketches/processing/rendered_archive/colors3/diagonal5.png) | ![colors30](sketches/processing/rendered_archive/colors30/diagonalck%20%285%29.png) |
| ![colors31](sketches/processing/rendered_archive/colors31/diagonalck%20%285%29.png) | ![colors32](sketches/processing/rendered_archive/colors32/diagonalck%20%285%29.png) | ![colors33](sketches/processing/rendered_archive/colors33/diagonalck%20%281%29.png) |
| ![colors34](sketches/processing/rendered_archive/colors34/diagonalck%20%281%29.png) | ![colors35](sketches/processing/rendered_archive/colors35/diagonal9.png) | ![colors36](sketches/processing/rendered_archive/colors36/diagonal2.png) |
| ![colors37](sketches/processing/rendered_archive/colors37/diagonal4.png) | ![colors38](sketches/processing/rendered_archive/colors38/diagonalck%20%285%29.png) | ![colors39](sketches/processing/rendered_archive/colors39/diagonalck%20%285%29.png) |
| ![colors4](sketches/processing/rendered_archive/colors4/diagonal5.png) | ![colors40](sketches/processing/rendered_archive/colors40/diagonalck%20%285%29.png) | ![colors41](sketches/processing/rendered_archive/colors41/diagonalck%20%285%29.png) |
| ![colors42](sketches/processing/rendered_archive/colors42/diagonalck%20%288%29.png) | ![colors4222](sketches/processing/rendered_archive/colors4222/diagonalck%20%288%29.png) | ![colors42a](sketches/processing/rendered_archive/colors42a/diagonalck%20%28444%29.png) |
| ![colors42avv](sketches/processing/rendered_archive/colors42avv/diagonalck%20%28444%29.png) | ![colors43](sketches/processing/rendered_archive/colors43/diagonalck%20%288%29.png) | ![colors44](sketches/processing/rendered_archive/colors44/diagonalck%20%2818%29.png) |
| ![colors45](sketches/processing/rendered_archive/colors45/diagonalck%20%2818%29.png) | ![colors46](sketches/processing/rendered_archive/colors46/diagonalck%20%2814%29.png) | ![colors46595](sketches/processing/rendered_archive/colors46595/diagonalck%20%2814%29.png) |
| ![colors46_Copy](sketches/processing/rendered_archive/colors46_Copy/diagonalck%20%2821%29.png) | ![colors46_Copy1](sketches/processing/rendered_archive/colors46_Copy1/diagonalck%20%2821%29.png) | ![colors47](sketches/processing/rendered_archive/colors47/diagonalck%20%2814%29.png) |
| ![colors48_1](sketches/processing/rendered_archive/colors48_1/diagonal5.png) | ![colors48_2](sketches/processing/rendered_archive/colors48_2/diagonal5.png) | ![colors48_3](sketches/processing/rendered_archive/colors48_3/diagonal5.png) |
| ![colors48_4](sketches/processing/rendered_archive/colors48_4/diagonal5.png) | ![colors48_41](sketches/processing/rendered_archive/colors48_41/diagonal5.png) | ![colors48_41_1](sketches/processing/rendered_archive/colors48_41_1/diagonal5.png) |
| ![colors48_5](sketches/processing/rendered_archive/colors48_5/diagonal5.png) | ![colors48_D](sketches/processing/rendered_archive/colors48_D/diagonal5.png) | ![colors49](sketches/processing/rendered_archive/colors49/diagonalck%20%287%29.png) |
| ![colors50](sketches/processing/rendered_archive/colors50/diagonalck%20%287%29.png) | ![colors51](sketches/processing/rendered_archive/colors51/diagonalck%20%2811%29.png) | ![colors52](sketches/processing/rendered_archive/colors52/diagonalck%20%2812%29.png) |
| ![colors6](sketches/processing/rendered_archive/colors6/diagonal5.png) | ![colors7](sketches/processing/rendered_archive/colors7/diagonal5.png) | ![colors8](sketches/processing/rendered_archive/colors8/diagonal5.png) |
| ![colors9](sketches/processing/rendered_archive/colors9/diagonal7.png) | ![connection](sketches/processing/rendered_archive/connection/diagonal15.png) | ![connection1](sketches/processing/rendered_archive/connection1/diagonal15.png) |
| ![connection2](sketches/processing/rendered_archive/connection2/diagonal15.png) | ![connection2m](sketches/processing/rendered_archive/connection2m/diagonal15.png) | ![connection2m1](sketches/processing/rendered_archive/connection2m1/diagonal15.png) |
| ![connection2m10](sketches/processing/rendered_archive/connection2m10/diagonal15.png) | ![connection2m101](sketches/processing/rendered_archive/connection2m101/e1.png) | ![connection2mV](sketches/processing/rendered_archive/connection2mV/diagonal15.png) |
| ![connection2mVC](sketches/processing/rendered_archive/connection2mVC/diagonal15.png) | ![connection_AGAIN](sketches/processing/rendered_archive/connection_AGAIN/diagonal10.png) | ![connections](sketches/processing/rendered_archive/connections/diagonal15.png) |
| ![connectionsbv](sketches/processing/rendered_archive/connectionsbv/diagonal15.png) | ![data](sketches/processing/rendered_archive/sketch_241219a/data/image.png) | ![element](sketches/processing/rendered_archive/element/diagonal5.png) |
| ![element2](sketches/processing/rendered_archive/element2/diagonal5.png) | ![element2_trang](sketches/processing/rendered_archive/element2_trang/diagonal5.png) | ![element2_trang1](sketches/processing/rendered_archive/element2_trang1/diagonal6.png) |
| ![element2_trang1nn](sketches/processing/rendered_archive/element2_trang1nn/x.png) | ![element3](sketches/processing/rendered_archive/element3/diagonal5.png) | ![element_1](sketches/processing/rendered_archive/element_1/diagonal5.png) |
| ![element_TRANG](sketches/processing/rendered_archive/element_TRANG/diagonal71.png) | ![line-000269](sketches/processing/fireworkx/line-000269.png) | ![line-000307](sketches/processing/fireworkx/line-000307.png) |
| ![GRAD](sketches/processing/rendered_archive/GRAD/lat-%23%23%234.png) | ![gradienter](sketches/processing/rendered_archive/gradienter/xcs.png) | ![gradienterup](sketches/processing/rendered_archive/gradienterup/xcs1.png) |
| ![gradienterup23](sketches/processing/rendered_archive/gradienterup23/xcs2.png) | ![IMG_TRANG](sketches/processing/rendered_archive/IMG_TRANG/sat11.png) | ![lo](sketches/processing/rendered_archive/lo/diagonal1.png) |
| ![log_spiral](sketches/processing/rendered_archive/log_spiral/diagonal1.png) | ![log_spiral_beauty](sketches/processing/rendered_archive/log_spiral_beauty/diagonal1.png) | ![log_spiral_beautyFUL](sketches/processing/rendered_archive/log_spiral_beautyFUL/diagonal1.png) |
| ![log_spiral_beautyFUL_again](sketches/processing/rendered_archive/log_spiral_beautyFUL_again/diagonal1.png) | ![log_spiral_tel](sketches/processing/rendered_archive/log_spiral_tel/diagonal1.png) | ![log_spiralexn](sketches/processing/rendered_archive/log_spiralexn/diagonal1.png) |
| ![log_spiralnj](sketches/processing/rendered_archive/log_spiralnj/diagonal1.png) | ![log_spiralon](sketches/processing/rendered_archive/log_spiralon/diagonal1.png) | ![log_spiraltest](sketches/processing/rendered_archive/log_spiraltest/diagonal1.png) |
| ![log_spiraltestING](sketches/processing/rendered_archive/log_spiraltestING/diagonal1.png) | ![log_spiraltestING12](sketches/processing/rendered_archive/log_spiraltestING12/diagonal1.png) | ![log_spiraltestlo](sketches/processing/rendered_archive/log_spiraltestlo/diagonal1.png) |
| ![number1](sketches/processing/rendered_archive/number1/lat-%23%23%23f.png) | ![number12](sketches/processing/rendered_archive/number12/lat-%23%23%23f.png) | ![PICPRO](sketches/processing/rendered_archive/PICPRO/Intelligent-Woman-Thinkingsae1.png) |
| ![PICPRO1](sketches/processing/rendered_archive/PICPRO1/eve1.png) | ![PICPRO3](sketches/processing/rendered_archive/PICPRO3/iss040e010643%20Moon_14851018951_o.png) | ![PICPRO4](sketches/processing/rendered_archive/PICPRO4/IMAG09242.png) |
| ![PICPRO5](sketches/processing/rendered_archive/PICPRO5/z%20%2813%291.png) | ![PICPRO6](sketches/processing/rendered_archive/PICPRO6/IMAG09242.png) | ![PICPRO7](sketches/processing/rendered_archive/PICPRO7/b1.png) |
| ![picproto](sketches/processing/rendered_archive/picproto/diagonalck%20%288%29.png) | ![rotating_arc_4_linesbool2](sketches/processing/rendered_archive/rotating_arc_4_linesbool2/diagonal11.png) | ![rotating_arc_4_linesbool2bn](sketches/processing/rendered_archive/rotating_arc_4_linesbool2bn/diagonal11.png) |
| ![rotating_arc_4_linesbool4](sketches/processing/rendered_archive/rotating_arc_4_linesbool4/diagonal2.png) | ![rotating_arc_4_linesbool5](sketches/processing/rendered_archive/rotating_arc_4_linesbool5/diagonal2.png) | ![rotating_arc_4_linesbool6](sketches/processing/rendered_archive/rotating_arc_4_linesbool6/diagonal2.png) |
| ![rotating_arc_4_linesbool7](sketches/processing/rendered_archive/rotating_arc_4_linesbool7/diagonal2.png) | ![rotating_arc_anc](sketches/processing/rendered_archive/rotating_arc_anc/diagonal10.png) | ![rotating_arc_anc_cam](sketches/processing/rendered_archive/rotating_arc_anc_cam/diagonal10.png) |
| ![rotating_arc_anc_spike](sketches/processing/rendered_archive/rotating_arc_anc_spike/diagonal10.png) | ![rotating_arc_anc_spike1](sketches/processing/rendered_archive/rotating_arc_anc_spike1/diagonal11.png) | ![rotating_arc_anc_spike2](sketches/processing/rendered_archive/rotating_arc_anc_spike2/diagonal11.png) |
| ![rotating_arc_anc_spikesent](sketches/processing/rendered_archive/rotating_arc_anc_spikesent/diagonal12.png) | ![rotating_arc_anc_spikesent11](sketches/processing/rendered_archive/rotating_arc_anc_spikesent11/diagonal14.png) | ![rotating_arc_anc_spikesent12](sketches/processing/rendered_archive/rotating_arc_anc_spikesent12/diagonal15.png) |
| ![scatter](sketches/processing/rendered_archive/scatter/diagonal15.png) | ![scatter_reb](sketches/processing/rendered_archive/scatter_reb/diagonal15.png) | ![scatter_UNBELIVEABLE](sketches/processing/rendered_archive/scatter_UNBELIVEABLE/diagonal15.png) |
| ![sine_6new](sketches/processing/rendered_archive/sine_6new/lat-%23%23%234.png) | ![sine_6new1](sketches/processing/rendered_archive/sine_6new1/lat-%23%23%235.png) | ![son](sketches/processing/rendered_archive/son/sat11.png) |
| ![son1](sketches/processing/rendered_archive/son1/sat11.png) | ![son10](sketches/processing/rendered_archive/son10/sat11X15.png) | ![son11](sketches/processing/rendered_archive/son11/sat11X20.png) |
| ![son111](sketches/processing/rendered_archive/son111/sat11X2207474.png) | ![son1125](sketches/processing/rendered_archive/son1125/sat11X20.png) | ![son2](sketches/processing/rendered_archive/son2/sat11.png) |
| ![son3](sketches/processing/rendered_archive/son3/sat11.png) | ![son7](sketches/processing/rendered_archive/son7/sat11.png) | ![son8](sketches/processing/rendered_archive/son8/sat11.png) |
| ![son9](sketches/processing/rendered_archive/son9/sat11.png) | ![TRANG](sketches/processing/rendered_archive/TRANG/sat11.png) |  |
<!-- GALLERY:END -->
