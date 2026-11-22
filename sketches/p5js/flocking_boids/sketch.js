/**
 * sketches/p5js/flocking_boids/sketch.js
 * --------------------------------------
 * Modernized dual-mode (Node + Browser) version of the Flocking Boids sketch
 * originally embedded in Render🎦p5js.ipynb, upgraded for deterministic
 * headless MP4/GIF rendering via scripts/render_p5_node.js.
 */

(function (globalScope) {
  function mulberry32(seed) {
    let a = (seed >>> 0) || 1337;
    return function () {
      a |= 0;
      a = (a + 0x6d2b79f5) | 0;
      let t = Math.imul(a ^ (a >>> 15), 1 | a);
      t = (t + Math.imul(t ^ (t >>> 7), 61 | t)) ^ t;
      return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
    };
  }

  class Boid {
    constructor(p, x, y, rng, col) {
      this.p = p;
      this.acceleration = p.createVector(0, 0);
      const ang = rng() * Math.PI * 2;
      this.velocity = p.createVector(Math.cos(ang), Math.sin(ang));
      this.position = p.createVector(x, y);
      this.r = 4.2;
      this.maxspeed = 4.0;
      this.maxforce = 0.08;
      this.col = col;
      this.trail = [];
    }

    run(boids, W, H) {
      this.flock(boids);
      this.update();
      this.borders(W, H);
      this.render();
    }

    applyForce(force) {
      this.acceleration.add(force);
    }

    flock(boids) {
      const sep = this.separate(boids).mult(1.9);
      const ali = this.align(boids).mult(1.0);
      const coh = this.cohesion(boids).mult(1.0);
      this.applyForce(sep);
      this.applyForce(ali);
      this.applyForce(coh);
    }

    update() {
      this.trail.push([this.position.x, this.position.y]);
      if (this.trail.length > 14) this.trail.shift();
      this.velocity.add(this.acceleration);
      this.velocity.limit(this.maxspeed);
      this.position.add(this.velocity);
      this.acceleration.mult(0);
    }

    seek(target) {
      const p = this.p;
      const desired = p.constructor.Vector.sub(target, this.position);
      desired.normalize().mult(this.maxspeed);
      const steer = p.constructor.Vector.sub(desired, this.velocity);
      steer.limit(this.maxforce);
      return steer;
    }

    borders(W, H) {
      if (this.position.x < -this.r) { this.position.x = W + this.r; this.trail = []; }
      if (this.position.y < -this.r) { this.position.y = H + this.r; this.trail = []; }
      if (this.position.x > W + this.r) { this.position.x = -this.r; this.trail = []; }
      if (this.position.y > H + this.r) { this.position.y = -this.r; this.trail = []; }
    }

    separate(boids) {
      const p = this.p;
      const desiredSep = 34.0;
      const steer = p.createVector(0, 0);
      let count = 0;
      for (const other of boids) {
        const d = p.dist(this.position.x, this.position.y, other.position.x, other.position.y);
        if (d > 0 && d < desiredSep) {
          const diff = p.constructor.Vector.sub(this.position, other.position);
          diff.normalize().div(d);
          steer.add(diff);
          count++;
        }
      }
      if (count > 0) steer.div(count);
      if (steer.mag() > 0) {
        steer.normalize().mult(this.maxspeed).sub(this.velocity).limit(this.maxforce);
      }
      return steer;
    }

    align(boids) {
      const p = this.p;
      const neighborDist = 70;
      const sum = p.createVector(0, 0);
      let count = 0;
      for (const other of boids) {
        const d = p.dist(this.position.x, this.position.y, other.position.x, other.position.y);
        if (d > 0 && d < neighborDist) {
          sum.add(other.velocity);
          count++;
        }
      }
      if (count > 0) {
        sum.div(count).normalize().mult(this.maxspeed);
        return p.constructor.Vector.sub(sum, this.velocity).limit(this.maxforce);
      }
      return p.createVector(0, 0);
    }

    cohesion(boids) {
      const p = this.p;
      const neighborDist = 70;
      const sum = p.createVector(0, 0);
      let count = 0;
      for (const other of boids) {
        const d = p.dist(this.position.x, this.position.y, other.position.x, other.position.y);
        if (d > 0 && d < neighborDist) {
          sum.add(other.position);
          count++;
        }
      }
      if (count > 0) return this.seek(sum.div(count));
      return p.createVector(0, 0);
    }

    render() {
      const p = this.p;
      // Trail ribbon
      if (this.trail.length > 1) {
        p.noFill();
        p.stroke(this.col[0], this.col[1], this.col[2], 70);
        p.strokeWeight(1.5);
        p.beginShape();
        for (const pt of this.trail) p.vertex(pt[0], pt[1]);
        p.endShape();
      }
      const theta = this.velocity.heading() + p.PI / 2;
      p.push();
      p.translate(this.position.x, this.position.y);
      p.rotate(theta);
      p.fill(this.col[0], this.col[1], this.col[2], 235);
      p.stroke(255, 220);
      p.strokeWeight(1.1);
      p.beginShape();
      p.vertex(0, -this.r * 2);
      p.vertex(-this.r, this.r * 2);
      p.vertex(this.r, this.r * 2);
      p.endShape(p.CLOSE);
      p.pop();
    }
  }

  function createSketch(p, cfg = {}) {
    const W = cfg.width || 1280;
    const H = cfg.height || 720;
    const seed = cfg.seed !== undefined ? cfg.seed : 2026;
    const rng = mulberry32(seed);
    const boids = [];
    const palette = [
      [56, 189, 248],
      [251, 191, 36],
      [244, 63, 94],
      [99, 102, 241],
    ];

    p.setup = function () {
      p.pixelDensity(1);
      p.createCanvas(W, H);
      for (let i = 0; i < 96; i++) {
        boids.push(new Boid(p, rng() * W, rng() * H, rng, palette[i % palette.length]));
      }
    };

    p.draw = function () {
      p.background(15, 23, 42);
      // Subtle reference grid
      p.stroke(30, 41, 59);
      p.strokeWeight(1);
      for (let x = 0; x < W; x += 64) p.line(x, 0, x, H);
      for (let y = 0; y < H; y += 64) p.line(0, y, W, y);

      for (const b of boids) b.run(boids, W, H);
    };
  }

  if (typeof module !== "undefined" && module.exports) {
    module.exports = createSketch;
  } else {
    globalScope.FlockingBoidsSketch = { createSketch };
  }
})(typeof globalThis !== "undefined" ? globalThis : window);
