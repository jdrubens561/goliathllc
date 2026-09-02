# Goliath Consulting LLC — website

Static implementation of the Claude Design handoff in `../project/Goliath Consulting.dc.html`.
No build step, no dependencies.

```
site/
├── index.html          all markup, one long scrolling page
├── styles.css          the design system (tokens at the top of the file)
├── script.js           scroll reveals + inquiry form
├── fetch-assets.sh     downloads the seven images into assets/
└── assets/             images (see "Images" below)
```

## Running it

Open `index.html`, or serve the folder:

```
python3 -m http.server -d site 8000
```

## Deploying

Upload the contents of `site/` to any static host — Netlify, Vercel, Cloudflare
Pages, S3, GitHub Pages. There is nothing to compile.

## Images — do this first

`assets/` ships empty. The seven images still live on the current Squarespace
CDN, and this session's network policy blocked that host, so they could not be
downloaded here. Run the script once from a machine with normal internet access:

```
cd site && ./fetch-assets.sh
```

Then commit `assets/`. Until that runs, the page renders correctly but with
seven broken images.

Known issue, flagged during design and still unresolved: the logo PNG has a
baked-in black background, so it sits as a dark square on the warm paper. A
transparent PNG or SVG dropped in at `assets/logo.png` fixes it with no code
change.

## The inquiry form

There is no backend. Submitting opens the visitor's email client with the fields
pre-filled and addressed to `aac@goliathconsultingllc.com`, so no inquiry is
silently lost. To switch to a hosted form service later, replace the submit
handler in `script.js` with a `fetch()` POST to the endpoint — the markup already
carries the right `name` attributes (`name`, `org`, `email`, `message`).

## Design notes

- Type: Source Serif 4 (headlines), Work Sans (body), IBM Plex Mono (labels),
  loaded from Google Fonts.
- Color: all tokens are CSS custom properties in `:root`. The gold accent is
  `--gold: #8a6a24`; changing that one value re-tints the whole site, matching
  the accent control in the prototype.
- Reveals: elements marked `data-reveal` are visible by default and replay a
  `rise` animation when they scroll into view, so nothing disappears if
  IntersectionObserver never fires. All animation is disabled under
  `prefers-reduced-motion`.
- Layout is fluid throughout via `clamp()` and `flex-wrap` — there are no
  breakpoints, and every list stretches to fill its row rather than leaving
  trailing gaps.
