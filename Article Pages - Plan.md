# Article Pages — Design Plan

Each civilization in the timeline links to its own article page
(`source/articles/<id>.html`). All 84 pages share one stylesheet,
`source/articles/article.css`, so the design is defined once and applied
everywhere.

## Goal

Turn the plain reference articles into editorial pages that feel like part of
the timeline — warm, typographic, and color-keyed to each civilization's
continent.

## Structure (unchanged, per-page HTML)

Every article keeps the same simple, script-free markup:

- `.back` — "← Back to timeline" link
- `<h1>` — civilization name
- `.meta` — `Continent · start – end`
- `<article>` — 3–4 factual paragraphs (origin, peak, decline/legacy)
- `.contemporaries` — "Meanwhile, elsewhere" box, 3 bullets on other continents
- `.more` — Wikipedia link

The only per-page addition is a `class="cont-<continent>"` on `<body>`,
stamped programmatically, which drives the color theme.

## Visual system

- **Continent color, everywhere it counts.** A CSS variable set per
  `cont-*` class colors the top band, the drop cap, the metadata swatch, the
  "Meanwhile" bullets and section label, and the Wikipedia button.
  Palette matches the timeline's **Vivid** set:
  - Africa — blue · Europe — green · Asia — amber
  - N. America — red · S. America — violet · Oceania — teal
- **Masthead tint.** A soft gradient in the continent color fades down from
  the top of the page behind the title.
- **Type.** Newsreader (serif) for the title, body, and reading text;
  IBM Plex Mono for the back link, metadata, section label, and button.
- **Lead paragraph.** Larger, darker, with a continent-colored drop cap.
- **Paper palette.** Background `#efece1`, card `#faf8f2`, ink `#2c2924` —
  identical to the timeline so pages feel continuous with it.
- **"Meanwhile" box.** Soft card with square continent-colored bullets.
- **Wikipedia link.** Pill button that fills with the continent color on hover.

## Fonts — loading note

Fonts load via `<link rel="stylesheet">` tags in each article's `<head>`
(not a CSS `@import`, which is render-blocking and stalled the page). Georgia /
monospace fallbacks are declared so pages remain readable if the font CDN is
unavailable.

## Maintenance

- **Restyle all pages at once:** edit `article.css` only.
- **Add a new article:** create `<id>.html` following the shared structure and
  add `class="cont-<continent>"` to `<body>`; it inherits the full theme.
- The stylesheet link carries a version query (`article.css?v=2`) so browsers
  and the preview server pick up CSS changes instead of serving a cached copy —
  bump the number when you edit the CSS.
