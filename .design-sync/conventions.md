# World History Timeline — design system

A **tokens-only** design system. The source is a static HTML site with no
component library, no build step, and no framework — so there are **no
components to import**. `window.WorldHistory` is an empty namespace and
`_ds_bundle.js` has no exports. Build UI as plain semantic HTML and style it
with the CSS custom properties below. That is the whole system.

## Setup

Link the styles entry point; there is no provider or wrapper to mount.

```html
<link rel="stylesheet" href="styles.css">
```

`styles.css` pulls the two Google fonts (Newsreader, IBM Plex Mono) and
`tokens/tokens.css`. Nothing else is required. Two optional root hooks:

- `<html data-palette="classic">` or `"muted"` — swaps the six continent hues.
  Omit for the default **Vivid** palette.
- `<body class="cont-asia">` — binds `--accent` to that continent's hue.
  Everything inside then resolves `var(--accent)`. Without a `cont-*` class,
  `--accent` stays `--ink` (near-black).

## The idiom: custom properties, no class vocabulary

There are **no utility classes and no component classes**. The only classes the
system defines are the six `.cont-*` accent binders. Style with `var(--*)`:

| Token | Value | Use |
|---|---|---|
| `--paper` | `#efece1` | page background |
| `--card` | `#faf8f2` | raised surface — cards, chips |
| `--ink` | `#2c2924` | primary text |
| `--ink-2` | `#5c574d` | secondary text |
| `--muted` | `#8a8377` | labels, metadata, timestamps |
| `--line` | `#d9d4c6` | borders, rules, grid lines |
| `--zebra` | `#e8e4d7` | alternating row tint |
| `--ring` | `rgba(44,41,36,0.12)` | focus / elevation ring |
| `--accent` | per `.cont-*` | the active continent hue |
| `--serif` | Newsreader stack | headings, body prose, numerals |
| `--mono` | IBM Plex Mono stack | labels, dates, UI chrome |

Continent hues, addressable directly when you need a specific one rather than
the active accent: `--africa` `--europe` `--asia` `--namerica` `--samerica`
`--oceania`.

**Type roles matter more than size.** Serif carries content — headings, prose,
years, big numerals. Mono carries chrome — labels, tags, back links, counts,
axis ticks — usually at 10–13px with `letter-spacing: 0.02em` and `--muted`.
Getting this split right is most of the look.

**The accent wash** — the one derived-color idiom in the system, used for the
header gradient on article pages:

```css
background:
  linear-gradient(180deg,
    color-mix(in srgb, var(--accent) 22%, transparent) 0,
    transparent 360px),
  var(--paper);
background-repeat: no-repeat;
```

**No spacing, size, or radius tokens exist.** Those are literals in the source
(radii cluster at 2–4px for chips, 12–14px for cards, `999px` for pills; body
prose is 18px/1.7). Use plain CSS values — don't invent `var(--space-*)`, it
won't resolve.

## Where the truth lives

- `styles.css` and `tokens/tokens.css` in this folder — the complete, authoritative
  token set. Read them before styling.
- No per-component docs exist, because no components do.

## Idiomatic example

```html
<body class="cont-asia">
  <article style="background: var(--card); border: 1px solid var(--line);
                  border-radius: 12px; padding: 20px; max-width: 700px;">
    <div style="font-family: var(--mono); font-size: 11px; letter-spacing: 0.02em;
                color: var(--muted); text-transform: uppercase;">
      Classical world · Asia
    </div>
    <h2 style="font-family: var(--serif); font-size: 20px; font-weight: 600;
               color: var(--ink); margin-top: 6px;">
      Han Dynasty
    </h2>
    <p style="font-family: var(--serif); font-size: 18px; line-height: 1.7;
              color: var(--ink-2); margin-top: 8px;">
      Centralized bureaucracy, the Silk Road, and paper.
    </p>
    <span style="display: inline-block; margin-top: 12px; padding: 3px 10px;
                 border-radius: 999px; background: var(--accent); color: var(--card);
                 font-family: var(--mono); font-size: 10px;">
      206 BCE – 220 CE
    </span>
  </article>
</body>
```

## Known gap: the globe is dark, and untokenized

`globe.html` renders on a dark surface (`#0b0e13` background, `#eef1f6` text,
`#aab3c2` secondary) using **hardcoded literals — not tokens**. There is no dark
theme in this system. If you build a dark surface, you are outside the token set;
the six continent hues are the only part that carries over (the globe uses them
verbatim).
