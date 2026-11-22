(() => {
  const P5_CDN = "https://cdnjs.cloudflare.com/ajax/libs/p5.js/1.11.3/p5.min.js";

  const state = {
    allItems: [],
    filtered: [],
    patternMap: [],
    categories: [],
    activeCategory: "All",
    searchQuery: "",
    index: 0,
    autoplayTimer: null,
    activeMode: "carousel",
    stageLight: false,
    p5LoadedPromise: null,
    posterScriptLoaded: false,
    boidsScriptLoaded: false,
    activePosterP5: null,
    activeBoidsP5: null
  };

  const els = {
    modeTabs: Array.from(document.querySelectorAll(".mode-tab")),
    views: {
      carousel: document.getElementById("view-carousel"),
      poster: document.getElementById("view-poster"),
      boids: document.getElementById("view-boids")
    },
    catPills: document.getElementById("category-pills"),
    searchInput: document.getElementById("carousel-search"),
    counter: document.getElementById("slide-counter"),
    stage: document.getElementById("carousel-stage"),
    stageImg: document.getElementById("stage-img"),
    stageLoading: document.getElementById("stage-loading"),
    stageError: document.getElementById("stage-error"),
    btnPrev: document.getElementById("btn-prev"),
    btnNext: document.getElementById("btn-next"),
    btnStageBg: document.getElementById("btn-stage-bg"),
    slideCat: document.getElementById("slide-cat"),
    slideTitle: document.getElementById("slide-title"),
    slideNote: document.getElementById("slide-note"),
    btnAutoplay: document.getElementById("btn-autoplay"),
    btnLightbox: document.getElementById("btn-lightbox"),
    btnSource: document.getElementById("btn-source"),
    btnFullRes: document.getElementById("btn-full-res"),
    filmstrip: document.getElementById("filmstrip"),
    patternGrid: document.getElementById("pattern-grid"),
    lightbox: document.getElementById("lightbox"),
    lightboxImg: document.getElementById("lightbox-img"),
    lightboxCaption: document.getElementById("lightbox-caption"),
    lightboxClose: document.getElementById("lightbox-close"),
    lightboxPrev: document.getElementById("lightbox-prev"),
    lightboxNext: document.getElementById("lightbox-next"),
    refsBtn: document.getElementById("refs-btn"),
    refsModal: document.getElementById("refs-modal"),
    refsClose: document.getElementById("refs-close"),
    posterSeed: document.getElementById("poster-seed"),
    btnRenderPoster: document.getElementById("btn-render-poster"),
    btnSavePoster: document.getElementById("btn-save-poster"),
    posterStatus: document.getElementById("poster-status"),
    posterMount: document.getElementById("poster-canvas-mount"),
    btnRestartBoids: document.getElementById("btn-restart-boids"),
    boidsStatus: document.getElementById("boids-status"),
    boidsMount: document.getElementById("boids-canvas-mount")
  };

  function formatBytes(bytes) {
    if (!bytes) return "";
    if (bytes >= 1048576) return `${(bytes / 1048576).toFixed(2)} MB`;
    return `${Math.round(bytes / 1024)} KB`;
  }

  function loadScriptOnce(src) {
    return new Promise((resolve, reject) => {
      const s = document.createElement("script");
      s.src = src;
      s.async = true;
      s.onload = () => resolve();
      s.onerror = () => reject(new Error(`Failed to load script: ${src}`));
      document.head.appendChild(s);
    });
  }

  function ensureP5() {
    if (window.p5) return Promise.resolve();
    if (!state.p5LoadedPromise) {
      state.p5LoadedPromise = loadScriptOnce(P5_CDN);
    }
    return state.p5LoadedPromise;
  }

  function teardownLiveCanvases() {
    if (state.activePosterP5) {
      state.activePosterP5.remove();
      state.activePosterP5 = null;
    }
    if (state.activeBoidsP5) {
      state.activeBoidsP5.remove();
      state.activeBoidsP5 = null;
    }
  }

  async function mountPosterCanvas() {
    const seedVal = parseInt(els.posterSeed.value, 10) || 2026;
    els.posterStatus.textContent = "Loading p5.js v1.11.3 and bundled Inter fonts…";
    try {
      await ensureP5();
      if (!state.posterScriptLoaded) {
        await loadScriptOnce("./sketches/jax_xla_tpu_poster.js");
        state.posterScriptLoaded = true;
      }
      if (document.fonts && document.fonts.load) {
        await Promise.all([
          document.fonts.load('300 16px "Inter Light"'),
          document.fonts.load('400 16px "Inter"'),
          document.fonts.load('600 16px "Inter SemiBold"')
        ]);
        await document.fonts.ready;
      }
      if (state.activePosterP5) {
        state.activePosterP5.remove();
        state.activePosterP5 = null;
      }
      els.posterMount.innerHTML = "";
      state.activePosterP5 = new window.p5(
        (p) => window.JaxXlaTpuPoster.createSketch(p, { width: 1200, height: 1600, seed: seedVal }),
        els.posterMount
      );
      els.posterStatus.textContent = `Rendered 1200×1600 live preview cleanly with seed ${seedVal}.`;
    } catch (err) {
      els.posterStatus.textContent = `Error rendering live poster: ${err.message}`;
    }
  }

  async function mountBoidsCanvas() {
    els.boidsStatus.textContent = "Loading p5.js v1.11.3 Flocking Boids simulation…";
    try {
      await ensureP5();
      if (!state.boidsScriptLoaded) {
        await loadScriptOnce("./sketches/flocking_boids.js");
        state.boidsScriptLoaded = true;
      }
      if (state.activeBoidsP5) {
        state.activeBoidsP5.remove();
        state.activeBoidsP5 = null;
      }
      els.boidsMount.innerHTML = "";
      state.activeBoidsP5 = new window.p5(
        (p) => window.FlockingBoidsSketch.createSketch(p, { width: 960, height: 540, seed: 2026 }),
        els.boidsMount
      );
      els.boidsStatus.textContent = "Running interactive Flocking Boids (960×540). Switching tabs pauses cleanly.";
    } catch (err) {
      els.boidsStatus.textContent = `Error launching Flocking Boids: ${err.message}`;
    }
  }

  function setMode(mode) {
    state.activeMode = mode;
    els.modeTabs.forEach((btn) => {
      const isAct = btn.dataset.mode === mode;
      btn.classList.toggle("active", isAct);
      btn.setAttribute("aria-selected", String(isAct));
    });
    Object.entries(els.views).forEach(([k, sec]) => {
      sec.hidden = k !== mode;
    });

    if (mode !== "carousel") stopAutoplay();
    if (mode !== "poster" && state.activePosterP5) {
      state.activePosterP5.remove();
      state.activePosterP5 = null;
    }
    if (mode !== "boids" && state.activeBoidsP5) {
      state.activeBoidsP5.remove();
      state.activeBoidsP5 = null;
    }

    if (mode === "poster") mountPosterCanvas();
    else if (mode === "boids") mountBoidsCanvas();

    updateUrlHash();
  }

  function stopAutoplay() {
    if (state.autoplayTimer) {
      clearInterval(state.autoplayTimer);
      state.autoplayTimer = null;
    }
    els.btnAutoplay.classList.remove("active");
    els.btnAutoplay.textContent = "Autoplay";
  }

  function toggleAutoplay() {
    if (state.autoplayTimer) {
      stopAutoplay();
      return;
    }
    state.autoplayTimer = setInterval(() => {
      stepSlide(1);
    }, 3000);
    els.btnAutoplay.classList.add("active");
    els.btnAutoplay.textContent = "Pause";
  }

  function applyFilters(preserveSlug = null) {
    const q = state.searchQuery.trim().toLowerCase();
    const cat = state.activeCategory;
    state.filtered = state.allItems.filter((it) => {
      if (cat === "All") {
        if (it.optInOnly) return false;
      } else if (it.category !== cat) {
        return false;
      }
      if (!q) return true;
      return (
        it.title.toLowerCase().includes(q) ||
        it.folder.toLowerCase().includes(q) ||
        (it.sourceLabel || "").toLowerCase().includes(q) ||
        it.category.toLowerCase().includes(q)
      );
    });

    if (preserveSlug) {
      const found = state.filtered.findIndex((it) => it.slug === preserveSlug);
      state.index = found >= 0 ? found : 0;
    } else {
      state.index = 0;
    }
    renderCategoryPills();
    renderFilmstrip();
    renderCurrentSlide();
  }

  function renderCategoryPills() {
    const counts = { All: state.allItems.filter((it) => !it.optInOnly).length };
    for (const it of state.allItems) {
      counts[it.category] = (counts[it.category] || 0) + 1;
    }
    const order = [
      "All",
      "Featured",
      "Colors & Lattices",
      "Rotating Arcs",
      "Log Spirals",
      "Connections",
      "Elements",
      "Fireworkx & Studies",
      "Animations (GIF)"
    ].filter((c) => counts[c]);

    els.catPills.innerHTML = "";
    for (const cat of order) {
      const btn = document.createElement("button");
      btn.type = "button";
      btn.className = "cat-pill" + (state.activeCategory === cat ? " active" : "");
      btn.textContent = `${cat} (${counts[cat]})`;
      btn.addEventListener("click", () => {
        state.activeCategory = cat;
        applyFilters();
      });
      els.catPills.appendChild(btn);
    }
  }

  function renderFilmstrip() {
    els.filmstrip.innerHTML = "";
    state.filtered.forEach((it, idx) => {
      const btn = document.createElement("button");
      btn.type = "button";
      btn.className = "thumb-btn" + (idx === state.index ? " active" : "");
      btn.title = it.title;
      btn.dataset.idx = String(idx);

      const img = document.createElement("img");
      img.src = it.previewUrl;
      img.alt = it.folder;
      img.loading = "lazy";
      img.decoding = "async";

      const lbl = document.createElement("span");
      lbl.className = "thumb-label";
      lbl.textContent = it.folder;

      btn.appendChild(img);
      btn.appendChild(lbl);
      btn.addEventListener("click", () => {
        state.index = idx;
        renderCurrentSlide();
      });
      els.filmstrip.appendChild(btn);
    });
  }

  function preloadNeighbor(offset) {
    if (state.filtered.length <= 1) return;
    const targetIdx = (state.index + offset + state.filtered.length) % state.filtered.length;
    const item = state.filtered[targetIdx];
    if (!item || item.mediaType === "gif") return;
    const pre = new Image();
    pre.src = item.previewUrl;
  }

  function updateUrlHash() {
    if (state.activeMode !== "carousel") {
      history.replaceState(null, "", `#mode=${state.activeMode}`);
      return;
    }
    const item = state.filtered[state.index];
    if (item) {
      history.replaceState(null, "", `#slide=${encodeURIComponent(item.slug)}`);
    }
  }

  function renderCurrentSlide() {
    const total = state.filtered.length;
    if (!total) {
      els.counter.textContent = "0 / 0";
      els.slideTitle.textContent = "No matching figures";
      els.slideCat.textContent = state.activeCategory;
      els.slideNote.textContent = "Clear or adjust the search box to view figures.";
      els.stageImg.removeAttribute("src");
      return;
    }

    if (state.index >= total) state.index = 0;
    if (state.index < 0) state.index = total - 1;
    const item = state.filtered[state.index];

    els.counter.textContent = `${state.index + 1} / ${total}`;
    els.slideCat.textContent = item.category;
    els.slideTitle.textContent = item.title;

    const sizeTxt = formatBytes(item.sizeBytes);
    const previewNote = item.optimizedPreview
      ? `Showing lighter JPG preview (${formatBytes(item.previewSizeBytes)}); full PNG is ${sizeTxt}.`
      : (sizeTxt ? `Original ${item.mediaType.toUpperCase()} (${sizeTxt}).` : "");
    const srcTxt = item.sourceLabel ? ` Source: ${item.sourceLabel}` : "";
    els.slideNote.textContent = `${item.description} ${previewNote}${srcTxt}`.trim();

    if (item.sourceUrl) {
      els.btnSource.href = item.sourceUrl;
      els.btnSource.hidden = false;
    } else {
      els.btnSource.hidden = true;
    }
    els.btnFullRes.href = item.fullUrl;

    els.stageError.hidden = true;
    els.stageLoading.hidden = false;
    els.stageImg.alt = item.title;

    const currentSrc = item.previewUrl;
    els.stageImg.onload = () => {
      els.stageLoading.hidden = true;
    };
    els.stageImg.onerror = () => {
      els.stageLoading.hidden = true;
      els.stageError.hidden = false;
      els.stageError.textContent = `Could not load ${currentSrc}`;
    };
    els.stageImg.src = currentSrc;
    if (els.stageImg.complete && els.stageImg.naturalWidth > 0) {
      els.stageLoading.hidden = true;
    }

    // Highlight active thumb inside filmstrip without scrolling the page vertically
    const thumbs = Array.from(els.filmstrip.querySelectorAll(".thumb-btn"));
    thumbs.forEach((btn, i) => {
      const act = i === state.index;
      btn.classList.toggle("active", act);
      if (act && els.filmstrip.clientWidth > 0) {
        const targetLeft = btn.offsetLeft - (els.filmstrip.clientWidth - btn.clientWidth) / 2;
        els.filmstrip.scrollLeft = Math.max(0, targetLeft);
      }
    });

    // Update lightbox if currently open
    if (!els.lightbox.hidden) {
      els.lightboxImg.src = item.fullUrl;
      els.lightboxCaption.textContent = `${item.title} (${item.sourceLabel || item.repoPath})`;
    }

    preloadNeighbor(-1);
    preloadNeighbor(1);
    updateUrlHash();
  }

  function stepSlide(delta) {
    if (!state.filtered.length) return;
    state.index = (state.index + delta + state.filtered.length) % state.filtered.length;
    renderCurrentSlide();
  }

  function jumpToSlug(slug) {
    setMode("carousel");
    state.activeCategory = "All";
    state.searchQuery = "";
    els.searchInput.value = "";
    applyFilters(slug);
    els.stage.scrollIntoView({ behavior: "smooth", block: "nearest" });
  }

  function renderPatternMap() {
    els.patternGrid.innerHTML = "";
    for (const pm of state.patternMap) {
      const card = document.createElement("button");
      card.type = "button";
      card.className = "pattern-card";
      card.dataset.targetSlug = pm.targetSlug;
      card.innerHTML = `
        <span class="pm-title">${pm.layer}</span>
        <span class="pm-pde">${pm.pde}</span>
        <span class="pm-desc">${pm.summary}</span>
      `;
      card.addEventListener("click", () => jumpToSlug(pm.targetSlug));
      els.patternGrid.appendChild(card);
    }
  }

  function openLightbox() {
    const item = state.filtered[state.index];
    if (!item) return;
    els.lightboxImg.src = item.fullUrl;
    els.lightboxCaption.textContent = `${item.title} (${item.sourceLabel || item.repoPath})`;
    els.lightbox.hidden = false;
  }

  function closeModals() {
    els.lightbox.hidden = true;
    els.refsModal.hidden = true;
  }

  function wireEvents() {
    els.modeTabs.forEach((btn) => {
      btn.addEventListener("click", () => setMode(btn.dataset.mode));
    });

    els.btnPrev.addEventListener("click", () => stepSlide(-1));
    els.btnNext.addEventListener("click", () => stepSlide(1));
    els.lightboxPrev.addEventListener("click", () => stepSlide(-1));
    els.lightboxNext.addEventListener("click", () => stepSlide(1));

    els.btnAutoplay.addEventListener("click", toggleAutoplay);
    els.btnLightbox.addEventListener("click", openLightbox);
    els.stageImg.addEventListener("click", openLightbox);

    els.btnStageBg.addEventListener("click", () => {
      state.stageLight = !state.stageLight;
      els.stage.classList.toggle("stage-light", state.stageLight);
      els.stage.classList.toggle("stage-dark", !state.stageLight);
      els.btnStageBg.textContent = state.stageLight ? "Dark Stage" : "Light Stage";
    });

    els.searchInput.addEventListener("input", () => {
      state.searchQuery = els.searchInput.value;
      applyFilters();
    });

    els.lightboxClose.addEventListener("click", closeModals);
    els.lightbox.addEventListener("click", (e) => {
      if (e.target === els.lightbox || e.target.classList.contains("lightbox-inner")) closeModals();
    });

    els.refsBtn.addEventListener("click", () => {
      els.refsModal.hidden = false;
    });
    els.refsClose.addEventListener("click", closeModals);
    els.refsModal.addEventListener("click", (e) => {
      if (e.target === els.refsModal) closeModals();
    });

    document.addEventListener("keydown", (e) => {
      if (e.key === "Escape") {
        closeModals();
        return;
      }
      if (!els.refsModal.hidden || state.activeMode !== "carousel") return;
      if (document.activeElement === els.searchInput) return;
      if (e.key === "ArrowLeft") stepSlide(-1);
      else if (e.key === "ArrowRight") stepSlide(1);
      else if (e.key === " ") {
        e.preventDefault();
        toggleAutoplay();
      }
    });

    // Touch swipe on carousel stage
    let touchX = null;
    els.stage.addEventListener("touchstart", (e) => {
      touchX = e.changedTouches[0]?.clientX ?? null;
    }, { passive: true });
    els.stage.addEventListener("touchend", (e) => {
      if (touchX === null) return;
      const dx = (e.changedTouches[0]?.clientX ?? touchX) - touchX;
      touchX = null;
      if (Math.abs(dx) > 42) stepSlide(dx < 0 ? 1 : -1);
    }, { passive: true });

    els.btnRenderPoster.addEventListener("click", mountPosterCanvas);
    els.btnSavePoster.addEventListener("click", () => {
      if (state.activePosterP5) {
        const seedVal = parseInt(els.posterSeed.value, 10) || 2026;
        state.activePosterP5.saveCanvas(`jax_xla_tpu_poster_seed_${seedVal}`, "png");
      }
    });
    els.btnRestartBoids.addEventListener("click", mountBoidsCanvas);
  }

  async function init() {
    wireEvents();
    try {
      const resp = await fetch("./gallery_manifest.json");
      if (!resp.ok) throw new Error(`HTTP ${resp.status}`);
      const manifest = await resp.json();
      state.allItems = manifest.items || [];
      state.patternMap = manifest.patternMap || [];
      renderPatternMap();

      const hash = window.location.hash || "";
      if (hash.startsWith("#mode=")) {
        const m = hash.slice(6);
        applyFilters();
        if (els.views[m]) setMode(m);
      } else if (hash.startsWith("#slide=")) {
        const s = decodeURIComponent(hash.slice(7));
        const target = state.allItems.find((it) => it.slug === s);
        if (target && target.optInOnly) state.activeCategory = target.category;
        applyFilters(s);
      } else {
        applyFilters();
      }
    } catch (err) {
      els.slideNote.textContent = `Could not load gallery_manifest.json (${err.message}).`;
    }
  }

  window.addEventListener("beforeunload", teardownLiveCanvases);
  document.addEventListener("DOMContentLoaded", init);
})();
