#!/usr/bin/env node
/**
 * scripts/render_p5_node.js
 * -------------------------
 * Pure Node.js p5.js (v1.11.3) + @napi-rs/canvas (Rust Skia) + jsdom renderer.
 * Executes p5.js sketches headlessly without Chrome/Chromium, supporting:
 *   - Deterministic PRNG seeding and resolution overrides
 *   - Bundled .otf / .ttf font registration via GlobalFonts
 *   - Single-frame high-res PNG export
 *   - Multi-frame MP4 / palette-optimized GIF animation export via ffmpeg
 */

const fs = require("fs");
const path = require("path");
const { spawn, execFileSync } = require("child_process");
const { JSDOM } = require("jsdom");
const { createCanvas, GlobalFonts, ImageData } = require("@napi-rs/canvas");

function parseArgs(argv) {
  const args = {
    sketch: null,
    width: 2400,
    height: 3200,
    frames: 1,
    fps: 30,
    seed: 2026,
    out: null,
    mp4: null,
    gif: null,
    fontDir: path.resolve(__dirname, "..", "assets", "fonts"),
    opts: {},
  };

  for (let i = 2; i < argv.length; i++) {
    const k = argv[i];
    const v = argv[i + 1];
    if (k === "--sketch" && v) { args.sketch = v; i++; }
    else if (k === "--width" && v) { args.width = parseInt(v, 10); i++; }
    else if (k === "--height" && v) { args.height = parseInt(v, 10); i++; }
    else if (k === "--frames" && v) { args.frames = parseInt(v, 10); i++; }
    else if (k === "--fps" && v) { args.fps = parseInt(v, 10); i++; }
    else if (k === "--seed" && v) { args.seed = parseInt(v, 10); i++; }
    else if (k === "--out" && v) { args.out = v; i++; }
    else if (k === "--mp4" && v) { args.mp4 = v; i++; }
    else if (k === "--gif" && v) { args.gif = v; i++; }
    else if (k === "--font-dir" && v) { args.fontDir = v; i++; }
    else if (k === "--opts" && v) { args.opts = JSON.parse(v); i++; }
    else if (k === "--help" || k === "-h") {
      console.log(
        "Usage: node scripts/render_p5_node.js --sketch <file.js> " +
        "[--width 2400] [--height 3200] [--frames 1] [--fps 30] [--seed 2026] " +
        "[--out out.png] [--mp4 out.mp4] [--gif out.gif] [--font-dir assets/fonts] [--opts '{}']"
      );
      process.exit(0);
    }
  }
  if (!args.sketch) {
    throw new Error("Missing required --sketch <path/to/sketch.js>");
  }
  return args;
}

function registerBundledFonts(fontDir) {
  if (!fontDir || !fs.existsSync(fontDir)) return [];
  const registered = [];
  for (const fname of fs.readdirSync(fontDir).sort()) {
    if (!/\.(otf|ttf|woff2?)$/i.test(fname)) continue;
    const fpath = path.join(fontDir, fname);
    const stem = fname.replace(/\.(otf|ttf|woff2?)$/i, "");
    let family = stem.replace(/[-_]+/g, " ");
    if (/-Regular$/i.test(stem)) {
      family = stem.replace(/-Regular$/i, "").replace(/[-_]+/g, " ");
    }
    try {
      GlobalFonts.registerFromPath(fpath, family);
      registered.push({ file: fname, family });
    } catch (err) {
      console.warn(`[p5-node] Warn: failed to register font ${fname}: ${err.message}`);
    }
  }
  return registered;
}

function setupNodeP5DOM(defaultW, defaultH) {
  const dom = new JSDOM("<!DOCTYPE html><html><body><div id='p5-root'></div></body></html>", {
    pretendToBeVisual: true,
    url: "http://localhost/",
  });

  const { window } = dom;
  const { document } = window;
  const skiaRegistry = new WeakMap();
  let lastCreatedSkia = null;

  function ensureSkia(el) {
    let entry = skiaRegistry.get(el);
    if (!entry) {
      const skiaCanvas = createCanvas(defaultW, defaultH);
      const ctx = skiaCanvas.getContext("2d");
      entry = { skiaCanvas, ctx };
      skiaRegistry.set(el, entry);
      lastCreatedSkia = skiaCanvas;
    }
    return entry;
  }

  // Mutate width/height IN PLACE so p5's cached drawingContext stays bound to the resized Skia surface.
  Object.defineProperty(window.HTMLCanvasElement.prototype, "width", {
    get() { return ensureSkia(this).skiaCanvas.width; },
    set(v) { ensureSkia(this).skiaCanvas.width = Number(v) || defaultW; },
    configurable: true,
  });
  Object.defineProperty(window.HTMLCanvasElement.prototype, "height", {
    get() { return ensureSkia(this).skiaCanvas.height; },
    set(v) { ensureSkia(this).skiaCanvas.height = Number(v) || defaultH; },
    configurable: true,
  });
  window.HTMLCanvasElement.prototype.getContext = function (type, opts) {
    return ensureSkia(this).skiaCanvas.getContext(type || "2d", opts);
  };
  window.HTMLCanvasElement.prototype.toDataURL = function (mime = "image/png") {
    return ensureSkia(this).skiaCanvas.toDataURL(mime);
  };
  window.HTMLCanvasElement.prototype.toBuffer = function (mime = "image/png") {
    return ensureSkia(this).skiaCanvas.toBuffer(mime);
  };

  global.window = window;
  global.document = document;
  Object.defineProperty(global, "navigator", { value: window.navigator, configurable: true, writable: true });
  global.screen = window.screen;
  global.HTMLElement = window.HTMLElement;
  global.HTMLCanvasElement = window.HTMLCanvasElement;
  global.HTMLImageElement = window.HTMLImageElement;
  global.Image = window.Image;
  global.ImageData = ImageData;
  global.Event = window.Event;
  global.CustomEvent = window.CustomEvent;
  window.dispatchEvent = () => true;
  global.requestAnimationFrame = (cb) => setTimeout(() => cb(Date.now()), 16);
  global.cancelAnimationFrame = (id) => clearTimeout(id);
  global.performance = performance;

  const p5 = require("p5");
  return {
    p5,
    root: document.getElementById("p5-root"),
    getSkiaForElement: (elt) => (elt ? ensureSkia(elt).skiaCanvas : lastCreatedSkia),
    getLastSkia: () => lastCreatedSkia,
  };
}

function resolveFfmpegBin() {
  for (const cand of ["/usr/bin/ffmpeg", "ffmpeg"]) {
    if (cand === "ffmpeg" || fs.existsSync(cand)) return cand;
  }
  return "ffmpeg";
}

async function encodeMp4FromFrames(pInstance, skiaCanvas, width, height, frames, fps, mp4Path) {
  fs.mkdirSync(path.dirname(path.resolve(mp4Path)), { recursive: true });
  const ffmpegBin = resolveFfmpegBin();
  const proc = spawn(
    ffmpegBin,
    [
      "-y",
      "-threads", "3",
      "-f", "rawvideo",
      "-pixel_format", "rgba",
      "-video_size", `${width}x${height}`,
      "-framerate", String(fps),
      "-i", "pipe:0",
      "-c:v", "libx264",
      "-pix_fmt", "yuv420p",
      "-preset", "fast",
      "-crf", "20",
      "-movflags", "+faststart",
      mp4Path,
    ],
    { stdio: ["pipe", "ignore", "pipe"] }
  );

  let stderr = "";
  proc.stderr.on("data", (d) => { stderr += d.toString(); });

  const writeBuf = (buf) =>
    new Promise((res, rej) => {
      const ok = proc.stdin.write(buf, (err) => (err ? rej(err) : res()));
      if (!ok) proc.stdin.once("drain", res);
    });

  for (let f = 0; f < frames; f++) {
    if (f > 0) {
      pInstance.redraw();
    }
    await writeBuf(skiaCanvas.data());
  }

  proc.stdin.end();
  await new Promise((res, rej) => {
    proc.on("close", (code) => {
      if (code === 0) res();
      else rej(new Error(`ffmpeg exited ${code}: ${stderr.slice(-500)}`));
    });
  });
}

async function main() {
  const args = parseArgs(process.argv);
  const t0 = Date.now();
  const fonts = registerBundledFonts(args.fontDir);
  const { p5, root, getSkiaForElement, getLastSkia } = setupNodeP5DOM(args.width, args.height);

  const sketchAbs = path.resolve(args.sketch);
  const loaded = require(sketchAbs);
  const factory =
    typeof loaded === "function"
      ? loaded
      : typeof loaded.createSketch === "function"
      ? loaded.createSketch
      : typeof loaded.default === "function"
      ? loaded.default
      : null;

  if (!factory) {
    throw new Error(`Sketch ${sketchAbs} must export a factory function (module.exports = (p, cfg) => { ... })`);
  }

  const config = {
    width: args.width,
    height: args.height,
    frames: args.frames,
    fps: args.fps,
    seed: args.seed,
    ...args.opts,
  };

  let pInstance = null;
  let drawCount = 0;
  let resolveFirstDraw = null;
  const firstDrawReady = new Promise((res) => { resolveFirstDraw = res; });

  new p5((p) => {
    factory(p, config);
    const origSetup = p.setup ? p.setup.bind(p) : null;
    const origDraw = p.draw ? p.draw.bind(p) : null;

    p.setup = () => {
      p.pixelDensity(1);
      if (origSetup) origSetup();
      p.noLoop();
      pInstance = p;
      if (!origDraw && resolveFirstDraw) {
        resolveFirstDraw();
        resolveFirstDraw = null;
      }
    };

    if (origDraw) {
      p.draw = () => {
        origDraw();
        drawCount += 1;
        if (drawCount === 1 && resolveFirstDraw) {
          resolveFirstDraw();
          resolveFirstDraw = null;
        }
      };
    }
  }, root);

  await firstDrawReady;
  const canvasElt = pInstance && pInstance._renderer ? pInstance._renderer.elt : null;
  const skiaCanvas = getSkiaForElement(canvasElt) || getLastSkia();
  const actualW = skiaCanvas.width;
  const actualH = skiaCanvas.height;

  console.log(
    `[p5-node] Sketch=${path.basename(sketchAbs)} | Canvas=${actualW}x${actualH} | Fonts=${fonts.map((f) => f.family).join(", ") || "system"} | Frames=${args.frames}`
  );

  if (args.mp4 && args.frames > 1) {
    await encodeMp4FromFrames(pInstance, skiaCanvas, actualW, actualH, args.frames, args.fps, args.mp4);
    console.log(`[p5-node] Saved MP4: ${args.mp4} (${(fs.statSync(args.mp4).size / 1e6).toFixed(2)} MB)`);
    if (args.gif) {
      fs.mkdirSync(path.dirname(path.resolve(args.gif)), { recursive: true });
      execFileSync(resolveFfmpegBin(), [
        "-y", "-threads", "3", "-i", args.mp4,
        "-vf", "fps=15,scale=640:-1:flags=lanczos,split[s0][s1];[s0]palettegen=max_colors=256[p];[s1][p]paletteuse=dither=bayer",
        args.gif,
      ]);
      console.log(`[p5-node] Saved GIF: ${args.gif} (${(fs.statSync(args.gif).size / 1e6).toFixed(2)} MB)`);
    }
  } else if (args.frames > 1) {
    for (let f = 1; f < args.frames; f++) {
      pInstance.redraw();
    }
  }

  if (args.out) {
    const outAbs = path.resolve(args.out);
    fs.mkdirSync(path.dirname(outAbs), { recursive: true });
    fs.writeFileSync(outAbs, skiaCanvas.toBuffer("image/png"));
    console.log(`[p5-node] Saved PNG: ${args.out} (${(fs.statSync(outAbs).size / 1e6).toFixed(2)} MB)`);
  }

  console.log(`[p5-node] Completed in ${((Date.now() - t0) / 1000).toFixed(2)}s`);
  process.exit(0);
}

main().catch((err) => {
  console.error("[p5-node] ERROR:", err);
  process.exit(1);
});
