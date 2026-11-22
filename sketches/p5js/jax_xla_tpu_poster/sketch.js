/**
 * sketches/p5js/jax_xla_tpu_poster/sketch.js
 * --------------------------------------------
 * Dual-mode (Pure Node.js render_p5_node.js + Browser p5.js) generative poster
 * synthesizing signature Processing 3 patterns from 1kaiser/proccessing_sketches:
 *   1. drawQuadrantsLattice       <- colors49.pde / colors52.pde (quadrants, plus_cross, dots)
 *   2. drawDiagonalWeaveAndHalo   <- colors48_4.pde / rotating_arc_4_linesbool2bn.pde (45-deg lerpColor weave)
 *   3. drawHarmonicTriadOrbs      <- colors49.pde / colors52.pde (volumetric filled open-arc spheres)
 *   4. drawSpectralArcRing        <- colors52.pde (ab 6-sector piecewise RGB spectrum PIE + sine_6new1 arc)
 *   5. drawLogSpiralPetalsAndCore <- log_spiraltestING12.pde (petals) + rotating_arc_anc_spikesent11.pde (radial spike quads)
 *   6. drawJaxXlaTpuBlockAndColophon <- log_spiraltestING12.pde (3x3 sentence.charAt(no) grid + colors49 fade rule)
 */

(function (globalScope) {
  function mulberry32(seed) {
    let a = (seed >>> 0) || 2026;
    return function () {
      a |= 0;
      a = (a + 0x6d2b79f5) | 0;
      let t = Math.imul(a ^ (a >>> 15), 1 | a);
      t = (t + Math.imul(t ^ (t >>> 7), 61 | t)) ^ t;
      return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
    };
  }

  // -------------------------------------------------------------------------
  // Pattern 1: 4-Quadrant Symmetric Lattice & Orbital Micro-Nodes
  // Adapted from colors49.pde & colors52.pde: quadrants(), plus_cross(), dots()
  // -------------------------------------------------------------------------
  function drawQuadrantsLattice(p, W, H, S, cx, cy, haloR, tx, ty, fontSize) {
    const step = S * 0.024;
    const crossLen = S * 0.0024;
    const maxDist = Math.hypot(W, H) * 0.56;
    const cNear = p.color(100, 116, 139, 75);
    const cFar = p.color(203, 213, 225, 0);

    // Clean gallery whitespace exclusions around header, colophon, and JAX/XLA/TPU typography
    const marginX = W * 0.062;
    const topSafe = H * 0.082;
    const botSafe = H * 0.905;
    const safeLeft = tx - fontSize * 1.75;
    const safeRight = tx + fontSize * 1.75;
    const safeTop = ty - fontSize * 2.35;
    const safeBottom = ty + fontSize * 2.35;

    function drawNode(x, y) {
      if (x < marginX || x > W - marginX || y < topSafe || y > botSafe) return;
      if (x > safeLeft && x < safeRight && y > safeTop && y < safeBottom) return;

      const dCenter = Math.hypot(x - cx, y - cy);
      if (dCenter < haloR * 0.95) return;

      const t = p.constrain(p.map(dCenter, haloR * 0.95, maxDist, 0, 1), 0, 1);
      const col = p.lerpColor(cNear, cFar, Math.pow(t, 0.85));
      p.stroke(col);

      const gridIx = Math.round((x - cx) / step);
      const gridIy = Math.round((y - cy) / step);
      if ((Math.abs(gridIx) + Math.abs(gridIy)) % 4 === 0) {
        p.strokeWeight(S * 0.00095);
        p.line(x - crossLen, y - crossLen, x + crossLen, y + crossLen);
        p.line(x - crossLen, y + crossLen, x + crossLen, y - crossLen);
      } else {
        p.strokeWeight(S * 0.0015);
        p.point(x, y);
      }

      // Signature concentric ring accents from colors49.pde dots()
      if (Math.abs(gridIx) % 7 === 0 && Math.abs(gridIy) % 7 === 0 && t < 0.68) {
        p.noFill();
        p.stroke(148, 163, 184, 42 * (1 - t));
        p.strokeWeight(S * 0.0007);
        p.ellipse(x, y, step * 0.52, step * 0.52);
        p.ellipse(x, y, step * 1.04, step * 1.04);
      }
    }

    for (let j = cy - step; j > topSafe; j -= step) {
      for (let i = cx + step; i < W - marginX; i += step) drawNode(i, j);
    }
    for (let j = cy; j > topSafe; j -= step) {
      for (let i = cx; i > marginX; i -= step) {
        if (j === cy && i === cx) continue;
        drawNode(i, j);
      }
    }
    for (let j = cy + step; j < botSafe; j += step) {
      for (let i = cx - step; i > marginX; i -= step) drawNode(i, j);
    }
    for (let j = cy; j < botSafe; j += step) {
      for (let i = cx; i < W - marginX; i += step) drawNode(i, j);
    }
  }

  // -------------------------------------------------------------------------
  // Pattern 2: Warm-Cream Luminous Halo + 45-Deg lerpColor Diagonal Weave
  // Adapted from colors48_4.pde & rotating_arc_4_linesbool2bn.pde
  // -------------------------------------------------------------------------
  function drawDiagonalWeaveAndCreamHalo(p, cx, cy, haloR, S) {
    const ctx = p.drawingContext;

    // Warm cream solar-field halo matching uploaded reference edge RGB(250, 242, 222)
    ctx.save();
    const grad = ctx.createRadialGradient(
      cx - haloR * 0.05,
      cy - haloR * 0.05,
      haloR * 0.12,
      cx,
      cy,
      haloR * 1.02
    );
    grad.addColorStop(0.0, "rgba(253, 247, 232, 0.98)");
    grad.addColorStop(0.62, "rgba(250, 242, 222, 0.94)");
    grad.addColorStop(0.91, "rgba(250, 242, 222, 0.78)");
    grad.addColorStop(0.97, "rgba(250, 242, 222, 0.34)");
    grad.addColorStop(1.0, "rgba(250, 242, 222, 0.0)");
    ctx.fillStyle = grad;
    ctx.beginPath();
    ctx.arc(cx, cy, haloR * 1.02, 0, Math.PI * 2);
    ctx.fill();
    ctx.restore();

    // Clipped 45-degree symmetric diagonal weave from colors48_4.pde
    ctx.save();
    ctx.beginPath();
    ctx.arc(cx, cy, haloR * 0.89, 0, Math.PI * 2);
    ctx.clip();

    const ic1 = p.color(245, 158, 11, 28);
    const ic2 = p.color(59, 130, 246, 20);
    const q = S * 0.012;
    const span = haloR * 0.94;
    const maxP = Math.SQRT2 * span;

    p.strokeWeight(S * 0.00125);
    for (let ps = q / 2; ps < maxP; ps += q) {
      const f = p.constrain(ps / maxP, 0, 1);
      p.stroke(p.lerpColor(ic1, ic2, f));
      p.line(cx + ps - span, cy - span, cx + ps + span, cy + span);
      p.line(cx - ps - span, cy - span, cx - ps + span, cy + span);
      p.line(cx + ps + span, cy - span, cx + ps - span, cy + span);
      p.line(cx - ps + span, cy - span, cx - ps - span, cy + span);
    }
    ctx.restore();

    // Subtle crisp boundary rings
    p.noFill();
    p.stroke(217, 179, 112, 65);
    p.strokeWeight(S * 0.00075);
    p.ellipse(cx, cy, haloR * 1.78, haloR * 1.78);
    p.stroke(203, 213, 225, 78);
    p.ellipse(cx, cy, haloR * 1.97, haloR * 1.97);
  }

  // -------------------------------------------------------------------------
  // Pattern 3: Volumetric Filled Open-Arc Harmonic Triad Orbs (colors49.pde)
  // Exact nested open-arc fill sweep: for (n = 180; n > 0; n -= step) arc(..., OPEN)
  // -------------------------------------------------------------------------
  function drawVolumetricFilledOrb(p, ox, oy, dia, cLight, cDeep, gapDeg, rotDeg, stepDeg, rimStroke) {
    p.noStroke();
    p.fill(255, 253, 248, 225);
    p.ellipse(ox, oy, dia, dia);

    const gap = p.radians(gapDeg);
    const rot = p.radians(rotDeg);
    for (let n = 180; n > 0; n -= stepDeg) {
      p.noStroke();
      p.fill(p.lerpColor(cDeep, cLight, n / 180.0));
      const rn = p.radians(n);
      p.arc(ox, oy, dia, dia, -rn + gap + rot, rn + gap + rot, p.OPEN);
      p.arc(ox, oy, dia, dia, -rn + gap * 2 + rot, rn + gap * 2 + rot, p.OPEN);
    }

    if (rimStroke) {
      p.noFill();
      p.stroke(rimStroke);
      p.strokeWeight(Math.max(1.2, dia * 0.004));
      p.ellipse(ox, oy, dia, dia);
    }
  }

  function drawHarmonicTriadOrbs(p, cx, cy, haloR, S) {
    // 1. Secondary XLA Cyan-Cobalt Volumetric Orb (lower-left)
    const xlaX = cx - haloR * 0.39;
    const xlaY = cy + haloR * 0.43;
    const xlaDia = haloR * 0.64;
    drawVolumetricFilledOrb(
      p,
      xlaX,
      xlaY,
      xlaDia,
      p.color(34, 211, 238, 22),
      p.color(37, 99, 235, 28),
      58,
      -42,
      6,
      p.color(37, 99, 235, 95)
    );

    // 2. Tertiary TPU Indigo-Obsidian Volumetric Orb (upper-right)
    const tpuX = cx + haloR * 0.43;
    const tpuY = cy - haloR * 0.39;
    const tpuDia = haloR * 0.46;
    drawVolumetricFilledOrb(
      p,
      tpuX,
      tpuY,
      tpuDia,
      p.color(165, 180, 252, 24),
      p.color(30, 41, 59, 34),
      55,
      115,
      6,
      p.color(79, 70, 229, 95)
    );

    // Connecting harmonic axis triangle (JAX - XLA - TPU) with vertex ticks
    p.noFill();
    p.stroke(15, 20, 25, 48);
    p.strokeWeight(S * 0.0009);
    p.strokeJoin(p.MITER);
    p.beginShape();
    p.vertex(cx, cy);
    p.vertex(xlaX, xlaY);
    p.vertex(tpuX, tpuY);
    p.endShape(p.CLOSE);

    p.noStroke();
    p.fill(37, 99, 235, 210);
    p.ellipse(xlaX, xlaY, S * 0.007, S * 0.007);
    p.fill(79, 70, 229, 210);
    p.ellipse(tpuX, tpuY, S * 0.007, S * 0.007);

    // 3. Primary JAX Amber-Gold-Coral Volumetric Sphere at main center
    const mainDia = haloR * 1.13;
    drawVolumetricFilledOrb(
      p,
      cx,
      cy,
      mainDia,
      p.color(253, 224, 71, 24),
      p.color(244, 63, 94, 24),
      60,
      15,
      5,
      p.color(245, 158, 11, 80)
    );
  }

  // -------------------------------------------------------------------------
  // Pattern 4: Razor-Sharp 6-Sector Spectral Collar & Sweeping Arc
  // Adapted from colors52.pde ab() / col() & sine_6new1.pde
  // -------------------------------------------------------------------------
  function drawSpectralArcRing(p, cx, cy, haloR, S) {
    const outerDia = haloR * 1.185;
    const innerDia = haloR * 1.132;
    const cmin = 80;
    const cmax = 248;
    const alp = 195;
    const span = cmax - cmin;
    const diff = 0.6;
    const rotOffset = -70;

    p.noStroke();
    for (let n = 0; n < 360; n += diff) {
      const no = (n * span * 6) / 360;
      const k = Math.min(5, Math.floor(no / span));
      const ll = k % 2 === 0 ? 1 : -1;
      const pv = Math.abs(no - k * span);

      let b1 = 0, b2 = 0, b3 = 0;
      if (k === 0) { b1 = cmin; b2 = cmin + ll * pv; b3 = cmax; }
      else if (k === 1) { b1 = cmin; b2 = cmax; b3 = cmax + ll * pv; }
      else if (k === 2) { b1 = cmin + ll * pv; b2 = cmax; b3 = cmin; }
      else if (k === 3) { b1 = cmax; b2 = cmax + ll * pv; b3 = cmin; }
      else if (k === 4) { b1 = cmax; b2 = cmin; b3 = cmin + ll * pv; }
      else { b1 = cmax + ll * pv; b2 = cmin; b3 = cmax; }

      p.fill(b1, b2, b3, alp);
      p.arc(
        cx,
        cy,
        outerDia,
        outerDia,
        p.radians(n + rotOffset),
        p.radians(n + diff + 0.25 + rotOffset),
        p.PIE
      );
    }

    // Crisp luminous inner stage for the lotus & radial spikes
    p.noStroke();
    p.fill(254, 252, 247, 246);
    p.ellipse(cx, cy, innerDia, innerDia);

    // Sweeping gradient outer open-arc accent (sine_6new1.pde / rotating_arc_4_linesbool2bn.pde)
    const arcDia = haloR * 1.32;
    const icA = p.color(14, 165, 233, 185);
    const icB = p.color(15, 23, 42, 210);
    p.noFill();
    p.strokeWeight(S * 0.0032);
    p.strokeCap(p.SQUARE);
    for (let n = 135; n > 0; n -= 1.0) {
      p.stroke(p.lerpColor(icA, icB, n / 135));
      const rn = p.radians(n);
      p.arc(cx, cy, arcDia, arcDia, -p.PI * 0.35 - rn, -p.PI * 0.35 + rn);
    }
  }

  // -------------------------------------------------------------------------
  // Pattern 5: Full 12-Fold Logarithmic Spiral Lotus + 3-Layer Spike Core
  // Exact petals() formulation from log_spiraltestING12.pde & rotating_arc_anc_spikesent11.pde
  // -------------------------------------------------------------------------
  function drawLogSpiralPetalsAndCore(p, cx, cy, haloR, S) {
    const h1 = 30; // 12 petals
    const s1 = haloR * 0.255;
    const g = 0.09;
    const radStep = p.radians(g);
    const aBase = s1 * Math.abs(Math.sin(h1 / 2)) * 0.145;

    const lotusPasses = [
      {
        sr: s1,
        ar: aBase,
        fill: p.color(244, 63, 94, 46),
        stroke: p.color(190, 18, 60, 155),
        sw: S * 0.0009,
      },
      {
        sr: s1 * 0.78,
        ar: aBase * 0.72,
        fill: p.color(251, 191, 36, 52),
        stroke: p.color(15, 23, 42, 145),
        sw: S * 0.00075,
      },
    ];

    for (const pass of lotusPasses) {
      p.fill(pass.fill);
      p.stroke(pass.stroke);
      p.strokeWeight(pass.sw);
      p.strokeJoin(p.ROUND);

      for (let ang = h1 / 2; ang < 360; ang += h1) {
        let t2 = radStep;
        let b = 1.0;
        const rn = p.radians(ang);
        p.beginShape();

        for (let o = 0; o < 1000; o++) {
          const x = cx + pass.sr * Math.cos(rn) + pass.ar * Math.exp(b * t2) * Math.cos(t2 + Math.PI / 2 + rn + Math.PI);
          const y = cy + pass.sr * Math.sin(rn) + pass.ar * Math.exp(b * t2) * Math.sin(t2 + Math.PI / 2 + rn + Math.PI);
          t2 += radStep;
          if (o % 10 === 0) p.vertex(x, y);
        }
        for (let o = 0; o < 1000; o++) {
          const x = cx + pass.sr * Math.cos(rn) + pass.ar * Math.exp(b * t2) * Math.cos(-t2 - Math.PI / 2 + rn + Math.PI);
          const y = cy + pass.sr * Math.sin(rn) + pass.ar * Math.exp(b * t2) * Math.sin(-t2 - Math.PI / 2 + rn + Math.PI);
          t2 -= radStep;
          if (o % 10 === 0) p.vertex(x, y);
        }
        b = 0.3;
        for (let o = 0; o < 1000; o++) {
          const x = cx + pass.sr * Math.cos(rn) + pass.ar * Math.exp(b * t2) * Math.cos(-t2 - Math.PI / 2 + rn + Math.PI);
          const y = cy + pass.sr * Math.sin(rn) + pass.ar * Math.exp(b * t2) * Math.sin(-t2 - Math.PI / 2 + rn + Math.PI);
          t2 += radStep;
          if (o % 10 === 0) p.vertex(x, y);
        }
        for (let o = 0; o < 1000; o++) {
          const x = cx + pass.sr * Math.cos(rn) + pass.ar * Math.exp(b * t2) * Math.cos(t2 + Math.PI / 2 + rn + Math.PI);
          const y = cy + pass.sr * Math.sin(rn) + pass.ar * Math.exp(b * t2) * Math.sin(t2 + Math.PI / 2 + rn + Math.PI);
          t2 -= radStep;
          if (o % 10 === 0) p.vertex(x, y);
        }
        p.endShape(p.CLOSE);
      }
    }

    // Beaded perimeter circle from log_spiraltestING12.pde (n += h1/4)
    p.stroke(15, 23, 42, 225);
    p.strokeWeight(S * 0.004);
    for (let n = 0; n < 360; n += h1 / 4) {
      const px = cx + s1 * Math.cos(p.radians(n));
      const py = cy + s1 * Math.sin(p.radians(n));
      p.point(px, py);
    }

    // B. 3-Layer Depth-Shaded Radial Spike-Quads (rotating_arc_anc_spikesent11.pde)
    const spikeR = haloR * 0.16;
    const hDeg = 10;
    const baseL = 4.6 * spikeR * Math.tan(p.radians(hDeg / 2));
    const spikeLayers = [
      { startDeg: 10, lMult: 1.0 },
      { startDeg: 8, lMult: 0.92 },
      { startDeg: 6, lMult: 0.78 },
    ];

    for (const layer of spikeLayers) {
      const l = baseL * layer.lMult;
      for (let n = layer.startDeg; n < 360; n += hDeg) {
        const a1 = cx + spikeR * Math.cos(1.5 * Math.PI + p.radians(n));
        const a2 = cy + spikeR * Math.sin(1.5 * Math.PI + p.radians(n));
        const b1 = cx + (spikeR + l) * Math.cos(1.5 * Math.PI + p.radians(n + hDeg / 2));
        const b2 = cy + (spikeR + l) * Math.sin(1.5 * Math.PI + p.radians(n + hDeg / 2));
        const c1 = cx + spikeR * Math.cos(1.5 * Math.PI + p.radians(n + hDeg));
        const c2 = cy + spikeR * Math.sin(1.5 * Math.PI + p.radians(n + hDeg));
        const d1 = cx + spikeR * Math.cos(1.5 * Math.PI + p.radians(n + hDeg / 2));
        const d2 = cy + spikeR * Math.sin(1.5 * Math.PI + p.radians(n + hDeg / 2));

        const f1 = cx + (spikeR + l * 1.4) * Math.cos(1.5 * Math.PI + p.radians(n + hDeg / 2));
        const f2 = cy + (spikeR + l * 1.4) * Math.sin(1.5 * Math.PI + p.radians(n + hDeg / 2));
        const e1 = cx + (spikeR + l * 1.2) * Math.cos(1.5 * Math.PI + p.radians(n + hDeg / 2));
        const e2 = cy + (spikeR + l * 1.2) * Math.sin(1.5 * Math.PI + p.radians(n + hDeg / 2));
        const g1 = cx + (spikeR + l * 1.56) * Math.cos(1.5 * Math.PI + p.radians(n + hDeg / 2));
        const g2 = cy + (spikeR + l * 1.56) * Math.sin(1.5 * Math.PI + p.radians(n + hDeg / 2));

        p.noStroke();
        p.fill(148, 163, 184, 155);
        p.quad(a1, a2, f1, f2, c1, c2, d1, d2);
        p.fill(203, 213, 225, 200);
        p.quad(a1, a2, e1, e2, c1, c2, d1, d2);
        p.fill(15, 20, 25, 240);
        p.quad(a1, a2, b1, b2, c1, c2, d1, d2);

        if (layer.startDeg === 10) {
          p.stroke(15, 20, 25, 195);
          p.strokeWeight(S * 0.0022);
          p.point(g1, g2);
        }
      }
    }

    // Crisp luminous center eye
    p.noStroke();
    p.fill(255, 255, 255, 248);
    p.ellipse(cx, cy, spikeR * 1.78, spikeR * 1.78);
    p.stroke(15, 20, 25, 230);
    p.strokeWeight(S * 0.002);
    p.noFill();
    p.ellipse(cx, cy, spikeR * 1.54, spikeR * 1.54);
    p.fill(249, 115, 22, 245);
    p.noStroke();
    p.ellipse(cx, cy, spikeR * 0.34, spikeR * 0.34);

    // Subtle harmonic sine bridge from sine_6new1.pde
    p.noFill();
    p.stroke(37, 99, 235, 92);
    p.strokeWeight(S * 0.00135);
    p.beginShape();
    for (let dx = -haloR * 0.84; dx <= haloR * 0.84; dx += S * 0.004) {
      const norm = dx / (haloR * 0.84);
      const env = Math.cos(norm * Math.PI * 0.5);
      const sy = cy + Math.sin(norm * Math.PI * 4.0) * haloR * 0.075 * env * env;
      p.vertex(cx + dx, sy);
    }
    p.endShape();
  }

  // -------------------------------------------------------------------------
  // Pattern 6: Pure 3x3 Character-Grid Typography ("JAXXLATPU") + Colophon
  // Exact sentence.charAt(no) proportions matching uploaded reference image
  // -------------------------------------------------------------------------
  function drawJaxXlaTpuBlockAndColophon(p, W, H, S, tx, ty, fontSize) {
    const sentence = "JAXXLATPU";
    const colStep = fontSize * 0.85;
    const rowStep = fontSize * 1.38;

    // Exact 3x3 nested character grid on spotless gallery paper, RGB(15, 20, 25)
    p.noStroke();
    p.fill(15, 20, 25, 255);
    p.textFont("Inter");
    p.textSize(fontSize);
    p.textAlign(p.CENTER, p.CENTER);

    let idx = 0;
    for (let r = -1; r <= 1; r++) {
      for (let c = -1; c <= 1; c++) {
        p.text(sentence.charAt(idx), tx + c * colStep, ty + r * rowStep);
        idx++;
      }
    }

    // Minimal Swiss exhibition header & bottom colophon with colors49.pde fade rule
    const marginX = W * 0.068;
    const topY = H * 0.052;
    const botY = H * 0.946;

    p.fill(71, 85, 105, 235);
    p.textFont("Inter Light");
    p.textSize(S * 0.0115);
    p.textAlign(p.LEFT, p.CENTER);
    p.text("01  //  PROCEDURAL PATTERNS ARCHIVE", marginX, topY);
    p.textAlign(p.RIGHT, p.CENTER);
    p.text("1KAISER / PROCCESSING_SKETCHES", W - marginX, topY);

    // Top subtle hairline rule
    p.stroke(226, 232, 240, 210);
    p.strokeWeight(S * 0.0007);
    p.line(marginX, topY + S * 0.022, W - marginX, topY + S * 0.022);

    // Bottom hairline fade rule (adapted from colors49.pde lines 1514-1518)
    const ruleY = botY - S * 0.024;
    p.strokeWeight(S * 0.0009);
    for (let x = marginX; x <= W - marginX; x += 3) {
      const fade = p.map(x, marginX, W - marginX, 185, 28);
      p.stroke(15, 23, 42, fade);
      p.line(x, ruleY, Math.min(x + 3, W - marginX), ruleY);
    }

    p.noStroke();
    p.fill(15, 20, 25, 245);
    p.textFont("Inter SemiBold");
    p.textSize(S * 0.013);
    p.textAlign(p.LEFT, p.CENTER);
    p.text("JAX  ·  XLA  ·  TPU", marginX, botY);

    p.fill(71, 85, 105, 235);
    p.textFont("Inter Light");
    p.textSize(S * 0.0112);
    p.textAlign(p.RIGHT, p.CENTER);
    p.text("P5.JS  ·  RUST SKIA / COLAB CLI EDITION", W - marginX, botY);
  }

  function createSketch(p, cfg = {}) {
    const W = cfg.width || 2400;
    const H = cfg.height || 3200;
    const seed = cfg.seed !== undefined ? cfg.seed : 2026;
    const S = Math.min(W, H);

    p.setup = function () {
      p.pixelDensity(1);
      p.createCanvas(W, H);
      p.noLoop();
    };

    p.draw = function () {
      mulberry32(seed);
      p.background(255);

      // Anchor orbital center & typography grid so warm cream halo gently kisses top-left of 'J'
      const cx = W * 0.43;
      const cy = H * 0.405;
      const haloR = W * 0.335; // ~804 px at W=2400 -> rim touches upper-left corner of 'J'

      const fontSize = Math.round(S * 0.078);
      const tx = W * 0.642;
      const ty = H * 0.722;

      drawQuadrantsLattice(p, W, H, S, cx, cy, haloR, tx, ty, fontSize);
      drawDiagonalWeaveAndCreamHalo(p, cx, cy, haloR, S);
      drawHarmonicTriadOrbs(p, cx, cy, haloR, S);
      drawSpectralArcRing(p, cx, cy, haloR, S);
      drawLogSpiralPetalsAndCore(p, cx, cy, haloR, S);
      drawJaxXlaTpuBlockAndColophon(p, W, H, S, tx, ty, fontSize);
    };
  }

  if (typeof module !== "undefined" && module.exports) {
    module.exports = createSketch;
  } else {
    globalScope.JaxXlaTpuPoster = { createSketch };
  }
})(typeof globalThis !== "undefined" ? globalThis : window);
