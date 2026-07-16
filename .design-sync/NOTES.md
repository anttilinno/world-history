# design-sync notes

## Why this sync is off-script

This repo is a static HTML site: no `package.json`, no lockfile, no `dist/`, no
components. `package-build.mjs` cannot run — there is nothing to bundle. The
`ds-bundle/` layout is **hand-built** and validated with `package-validate.mjs`,
which supports this as a first-class case (`componentCount: 0` → "tokens-only DS").

Rebuild procedure (no build script — it's this short on purpose):

1. Edit `.design-sync/conventions.md` (the human-owned source of truth).
2. `cp .design-sync/conventions.md ds-bundle/README.md`
3. Regenerate `ds-bundle/_ds_sync.json` — `styleSha` via `lib/sync-hashes.mjs`
   `styleShaFor(OUT, {includeBundleBody: true})`, `bundleSha12` =
   `sha256(_ds_bundle.js).slice(0,12)`. The anchor must describe the bundle or
   validate fails with a stale-anchor error.
4. `node <skill>/package-validate.mjs ds-bundle --no-render-check` → must exit 0.

`--no-render-check` is required and honest here: there are no previews to render,
and playwright isn't installed (no `node_modules` at all). The resulting
`[RENDER_SKIPPED]` warning is vacuous — zero previews were skipped.

## Token sources (all three agree; verified 2026-07-16)

- `index.html` `:root` — the full set incl. `--zebra` and the three palettes.
- `articles/article.css` `:root` — same base; adds `--accent` + `.cont-*` binders.
- `globe.html` `:root` — continent hues + fonts only, identical values.

If any of these drift apart, `tokens/tokens.css` is wrong. There is no single
source file in the repo to generate from — the tokens are duplicated across all
three by hand. **This is the main fragility of this sync.**

## Findings

- **The globe is dark and untokenized.** `globe.html` hardcodes `#0b0e13`
  (background), `#eef1f6` (text), `#aab3c2` (secondary), plus panel surfaces
  `rgba(12,16,22,0.66–0.72)` and `rgba(255,255,255,0.12)` borders. These are
  literals, not custom properties. No dark tokens were invented for them —
  promoting literals to tokens would be fabricating a system the repo doesn't
  have. Recorded in the README as a known gap. If a dark theme is ever wanted,
  it should be built in the repo first, then synced.
- **No spacing/size/radius tokens exist.** All literals (radii 2–4px chips,
  12–14px cards, 999px pills; body 18px/1.7). The README says so explicitly so
  the design agent doesn't invent `var(--space-*)`.
- **Fonts ship via remote `@import`** (Google Fonts), matching what the site
  already does — no woff2 vendoring. Verified in-browser: 27 font faces load,
  `document.fonts.check()` passes for both Newsreader and IBM Plex Mono. The
  validator blesses this as `[FONT_REMOTE]`. Designs rendered without network
  fall back to Georgia / Menlo, which are already in the stacks.

## Verification performed (2026-07-16)

Rendered the README's example snippet against the real `styles.css` closure and
read computed styles (the Browser pane's screenshot action timed out; computed
styles are a stronger check anyway — exact values, not eyeballing):

- `--paper` → `rgb(239,236,225)`, `--card` → `rgb(250,248,242)`,
  `--line` → `rgb(217,212,198)` — all match source.
- `.cont-asia` binds `--accent` → `#d99400`; rebinding to `.cont-samerica`
  → `#7a5cc8`. Accent mechanism works.
- `data-palette` swap: vivid `#d99400` → classic `#b0823f` → muted `#ad9d72`.
- All six continent swatches resolve to their exact source hex.
- Every token/class name enumerated in `conventions.md` verified present in
  `tokens/tokens.css` and value-matched against `index.html`.

## Out of scope

`vendor/globe.gl.min.js` and `vendor/earth-day.jpg` are third-party/asset files,
not design system material. Not synced.
