# Roadmap

Goal: **"The history map you wish you had in school."** A small number of big
ideas, with enough hooks that a curious child can dive into details.

## Shipped

- ✅ **#1 Zoom levels** — planet view = the grid & globe; civilization view =
  the sub-period timeline in each card (`PERIODS` in `index.html`); human-story
  view = the transition bands.
- ✅ **#2 "Meanwhile"** — every detail card lists contemporaries on other
  continents.
- ✅ **#3 Big transitions** — a labelled band between every pair of era rows.
- ✅ **#4 Why-chains** — each transition band carries its one-line cause.
- ✅ **#5 Interactive globe** — `globe.html`, `globe.gl` + a time slider.
- ✅ **All fast wins** — Meanwhile, deep links, year probe, search, Surprise me,
  span bar.

Every roadmap headline is now shipped in some form. What remains is depth:
sub-periods for more of the 84 civilizations, and the deeper zoom sketches below.

## 1. Multiple zoom levels

Like Google Maps:

- **Planet view** — humans appear → agriculture → civilizations → industrialization.
- **Civilization view** — e.g. Egypt: Old Kingdom → Middle Kingdom → Ptolemaic Egypt.
- **Human story view** — how did farming lead to cities? Why did empires form?

Shipped as a first pass (see above); only 6 civilizations have `PERIODS` so far.

## 2. Always show "what else was happening"

For every event, a "Meanwhile:" panel. Example — 480 BCE, Battle of Thermopylae:

- Buddha's teachings spread in India
- Confucius' ideas shape China
- Persian Empire dominates much of the Middle East
- Early Maya cities grow

This single feature fixes a huge blind spot: history is usually taught one
region at a time, so simultaneity is invisible.

## 3. Teach the big transitions

The memorable things are not kings and battles, but the phase changes:

- Hunting → farming
- Villages → cities
- Cities → states
- States → empires
- Empires → nations
- Industry → information age

These are the gears turning underneath history.

## 4. Use "why questions"

Causal chains are more memorable than dates:

- *"Why did civilizations appear near rivers?"*
  → farming surplus → specialists → writing → administration → armies → states
- *"Why did Rome fall?"*
  → economic pressure + political instability + military problems + external migrations

History becomes a detective story instead of a cemetery of dates.

## Fast wins

Small features the current code and data already support — no new
dependencies, each a few lines in `index.html`:

- **"Meanwhile" panel in the detail card.** Filter `CIVS` for civilizations
  whose date range overlaps the selected one, on other continents; list them
  as clickable links in the card. Ships idea #2 with zero new data.
- **Deep links.** Opening `#ancient-egypt` opens that card on load; update
  the hash when a card opens. Makes individual civilizations shareable.
- **Year probe.** Enter a year (e.g. 480 BCE) → chips alive that year stay
  lit, the rest dim. A cheap 2D preview of the globe's era slider.
- **Search box.** Type to highlight matching chips, dim the rest.
- **"Surprise me" button.** Opens a random civilization's card.
- **Span bar in the card.** A small horizontal bar showing the civilization's
  lifespan against the whole 300,000-year axis — instant "how long ago, how
  long it lasted" intuition. Pure CSS.

## 5. Interactive globe

A spinning 3D earth with civilizations placed geographically and an era
slider — scrub time, watch civilizations light up and fade where they
actually lived. The strongest possible form of "what else was happening":
simultaneity becomes literally visible.

Feasibility: high. WebGL via a JS library (`globe.gl` is purpose-built for
this — points/arcs/labels on a globe from a single script include; three.js
or CesiumJS for more control). WebAssembly is *not* the right tool: globe
rendering is GPU-bound, so WASM adds a compile toolchain and build step —
which this repo deliberately avoids — without making anything faster. Our
dataset (84 civilizations) is tiny; there is no compute bottleneck to solve.

Sketch: vendor `globe.gl`, feed it `data.js` (needs lat/lng added per
civilization), add an era slider that filters by `start`/`end`.
