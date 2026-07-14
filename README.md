# World History Timeline

An interactive map of 300,000 years of human history: **84 civilizations**
laid out as an **8-era × 6-continent grid**. Read across a row to see what
every continent was doing at once; read down a column to follow one region
through time.

Static site — no build step, no dependencies. Open `index.html` in a browser.

Future ideas live in [ROADMAP.md](ROADMAP.md).

## Layout

- **Rows = eras** (8): Deep prehistory → First farmers → Bronze Age →
  Classical world → Medieval → Early modern → Industrial → Contemporary.
- **Columns = continents** (6): Africa, Europe, Asia, North America,
  South America, Oceania.
- **Cells = chips**, one per civilization active in that era + continent.
  A **filled** chip *begins* in that era; a **dashed** chip *carries over*
  from an earlier one.

## Interaction

- Click a chip → detail card (continent, date range, span, blurb, links to the
  article and Wikipedia).
- Click a continent in the legend to hide the other columns' chips; click
  again to restore. Multi-select works.
- Palette tweak: Vivid (default), Classic, Muted.

## Files

- `index.html` — the timeline (self-contained; loads `data.js`).
- `data.js` — the 84 civilizations: `{id, name, continent, start, end, blurb, wiki}`.
  Years are negative for BCE, positive for CE, `2026` = present.
- `articles/<id>.html` — one editorial article per civilization, linked from
  each detail card. All share `articles/article.css`, themed per continent.

## Adding a civilization

1. Add a line to `data.js`.
2. Create `articles/<id>.html` following an existing article's structure, with
   `class="cont-<continent>"` on `<body>` — it inherits the full theme.
