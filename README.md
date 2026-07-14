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

Between each pair of era rows sits a **transition band** — the phase change
that turns one era into the next (Hunting → farming, Cities → states, …) with a
one-line "why".

## Interaction

- Click a chip → detail card: date range, a **span bar** placing the
  civilization on the whole 300,000-year axis, a **"Periods within"**
  sub-timeline for major civilizations (Egypt's Old/Middle/New Kingdom…), the
  blurb, **why it rose and why it fell**, a **"Meanwhile elsewhere"** panel of
  contemporaries on other continents, and links to the article and Wikipedia.
  The card is deep-linkable (`index.html#ancient-egypt`).
- **Year** box — type a year (`480 BCE`, `1500`) to keep only chips alive then lit.
- **Find** box — type to highlight chips by name.
- **Surprise me** — opens a random civilization.
- **🌍 Globe** — opens `globe.html`: a spinning earth with every civilization
  at its real location (markers sized by longevity) and a time slider that
  steps through history; drag or hit Play to watch them light up and fade, and
  toggle **Routes** to see the great migrations and trade routes as animated
  arcs that appear for the centuries they were active.
- Click a continent in the legend to hide the other columns' chips; click
  again to restore. Multi-select works.
- Palette tweak: Vivid (default), Classic, Muted.

## Files

- `index.html` — the timeline (self-contained; loads `data.js`). Also holds two
  optional inline maps keyed by civ id: `PERIODS` (sub-period timelines) and
  `WHY` (rise/fall one-liners).
- `globe.html` — the 3D globe view. Loads `data.js` plus inline data: a
  per-civilization `COORDS` map and a `ROUTES` list of migration/trade arcs
  (kept out of `data.js` so its one-line-per-civ format stays greppable).
- `data.js` — the 84 civilizations: `{id, name, continent, start, end, blurb, wiki}`.
  Years are negative for BCE, positive for CE, `2026` = present.
- `articles/<id>.html` — one editorial article per civilization, linked from
  each detail card. All share `articles/article.css`, themed per continent.
- `vendor/` — `globe.gl.min.js` (bundles three.js) and `earth-day.jpg`,
  vendored so the globe works offline with no build step.

## Adding a civilization

1. Add a line to `data.js`.
2. Add its `id: [lat, lng]` to the `COORDS` map in `globe.html` so it appears on
   the globe (omit it and it's silently skipped there).
3. Create `articles/<id>.html` following an existing article's structure, with
   `class="cont-<continent>"` on `<body>` — it inherits the full theme.

Optional extras, all keyed by the same `id`: a `WHY` entry (`{rise, fall}`) and
a `PERIODS` array in `index.html`; each is shown only if present.
