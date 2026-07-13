# World History Timeline — Plan

An interactive, vertical exploration of 300,000 years of human history across
84 civilizations and 6 continents, built as a single Design Component
(`World History Timeline.dc.html`).

## Problem this solves

The previous chart failed both ways: horizontal was cramped, vertical was
unusable. Root cause was packing continuous, wildly-uneven timespans (from
300,000-year prehistoric bands to 30-year events) into overlapping bars.

The fix is **structural, not cosmetic**: discretize time into named eras so
nothing overlaps by construction.

## Chosen direction — Era × Continent matrix (option 1c)

A grid instead of a free timeline.

- **Rows = eras** (8): Deep prehistory → First farmers → Bronze Age →
  Classical world → Medieval → Early modern → Industrial → Contemporary.
  Each row carries its date range and a one-line context note.
- **Columns = continents** (6): Africa, Europe, Asia, North America,
  South America, Oceania.
- **Cells = chips**, one per civilization active in that era + continent.
  - **Filled chip** = the civilization *begins* in this era.
  - **Dashed / outlined chip** = it *carries over* from an earlier era
    (e.g. Rome appears in both Classical and Medieval rows).

### Why this reads well

- Read **across a row** → what every continent was doing at the same moment.
- Read **down a column** → one region's arc through time.
- No overlap, no lane-packing, no log-scale distortion — cramping is
  eliminated by the data model itself.

## Interaction

- Click any chip → detail card (bottom-right) with continent, date range,
  span in years, blurb, and links to the full article + Wikipedia.
- Sticky era header column and continent header row while scrolling.
- Close card with the × button.

## Style system

- **Palette:** warm paper background (`#efece1`), zebra-striped rows.
  Continent colors via a 3-way tweak — **Vivid (default)**, Classic, Muted.
- **Type:** Newsreader (serif) for titles and era labels; IBM Plex Mono for
  dates, labels, and metadata; system sans for body.
- **Tweaks panel:** `palette` selector.

## Data

- `civs.js` — 84 civilizations `{id, name, continent, start, end, blurb, wiki}`.
  Years negative = BCE, positive = CE, 2026 = present.
- `source/articles/*.html` — one encyclopedic article per civilization,
  linked from each detail card.

## Rejected alternatives (turn 1 explorations)

- **1a Swimlanes** — refined per-continent columns on an era-weighted scale;
  readable but still tall and lane-packed.
- **1b Chronicle feed** — single merged chronological stream; good for reading,
  weak for cross-continent comparison.
- **1d Era lens (dark)** — overview strip + one era zoomed; powerful but a
  heavier interaction model.

## Possible next steps

- Search / filter by continent or keyword.
- A compact "surprising overlaps" callout strip.
- Print / PDF export of the full matrix.
