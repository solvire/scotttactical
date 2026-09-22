---
date: 2026-09-21T18:00:00-07:00
draft: false
title: "Site Redesign: Out With the Bootstrap 3 Theme"
url: /site-redesign-2026/
categories:
  - Software
tags: [ hugo, design, meta ]
comments: false
---

## Site Redesign 2026

### TL;DR

The site has a new visual theme. The old Bootstrap 3 "Beg" theme is retired
(kept in the repo for rollback). The new one is hand-rolled, has light and
dark color schemes, loads zero third-party assets, and every URL stayed
exactly the same.

### Designer credit

This redesign was designed and implemented by **Kilo**, an AI coding agent,
working from a short design brief: "modern, clean, fast, mobile-first; a
pragmatic engineer's field notes and photo trips; typography over ornament."
The brief, the hard constraints (no URL changes, no content loss, keep the
build plain Hugo), and the final approval were human. The theme code, the
CSS, the verification, and this write-up's factual content are the agent's.

It seemed worth saying out loud, since the site has a decade of human-written
posts and this is the first artifact on it authored by a machine.

### The build, by the numbers

For the statistically curious - measured where possible, estimated where
labelled:

- **Wall clock:** ~15 minutes for the audit + design proposal, ~15 minutes for
  the full implementation and verification. Call it 30 minutes end to end,
  including the docs. A human doing the same theme port is booking a weekend.
- **The model:** this session ran on **Kimi** (Moonshot AI), invoked through
  the OpenRouter API as `moonshotai/kimi-latest`, inside the Kilo agent
  harness. Tool calls (read/write/edit/shell) are executed by the harness;
  the model decides what to do and writes the code.
- **Files touched:** 19 new theme files (layouts, partials, shortcodes,
  theme.toml, 2 stylesheets), 6 site-level layouts rewritten, 1 config file
  edited, 1 doc written, 12 screenshots captured. The theme's CSS is ~420
  lines, hand-written; there is no CSS framework anywhere in it.
- **Builds:** 6 full Docker builds of the site during development, plus one
  "before" build of the old theme for comparison screenshots. Each build is
  ~2 seconds for 187 pages (Hugo is absurdly fast), so iteration was
  effectively free.
- **Bugs found by building, not by reading:** 2 (the ignored `markup.unsafe`
  setting and the `main.css` filename collision). Both were caught within one
  build-and-screenshot cycle each.
- **Tokens (estimate):** the harness does not expose an exact count to the
  agent, but the session transcript - repo audit, ~30 file reads/writes, 6
  builds, 15 screenshots analyzed - is on the order of a few hundred thousand
  tokens, most of it reading files and image attachments rather than
  generating code. At current API prices that puts the whole redesign in the
  single-digit dollars.
- **Human time:** one design brief, three multiple-choice decisions (theme
  approach, dark/light handling, syntax highlighting), and a final review.

### What was wrong with the old theme

The previous theme was `hugo_theme_beg`, a Bootstrap 3 design from the
mid-2010s:

- It pulled Bootstrap, jQuery, Font Awesome, and highlight.js 8.4 from CDNs
  (`maxcdn.bootstrapcdn.com`, `cdnjs.cloudflare.com`, `code.jquery.com`).
  Some of those URLs have been dead for years; the rest were privacy and
  performance dead weight.
- Bootstrap 3 aesthetics - panels, glyphicons, the navbar - read as dated
  now.
- A JavaScript framework (jQuery) to collapse a two-item navigation menu.

### The new theme

`themes/scott/`, hand-rolled:

- **No frameworks, no CDN.** All CSS is one file
  (`scott.css`, ~400 lines). The only JavaScript left on the site is the
  vendored PhotoSwipe for galleries and the (optional, config-gated)
  Disqus/Analytics snippets that were already there.
- **Light and dark schemes** via CSS custom properties and
  `prefers-color-scheme`. It follows the OS setting; no toggle, no JS.
- **System font stack.** No webfont downloads - the first render is just
  HTML and one local stylesheet.
- **Fluid type scale** with `clamp()`, a ~68ch reading measure, and a
  mobile-first layout where the sidebar stacks below the content.
- **Server-side syntax highlighting.** Code blocks are highlighted at build
  time by Hugo's Chroma engine (solarized-dark palette, readable in both
  color schemes) instead of a client-side script from 2014.
- **Gallery grid** rebuilt on CSS grid with lazy-loading thumbnails, keeping
  the existing front-matter-driven image list and the PhotoSwipe markup
  contract.

### Fixed along the way

Two latent config bugs surfaced during verification:

1. `markup.unsafe = true` is not honored by modern Hugo - the setting moved
   to `markup.goldmark.renderer.unsafe`. Raw HTML embedded in old posts was
   being silently dropped from the output. Fixed; the affected posts render
   their figures and iframes again.
2. The theme's stylesheet was initially named `main.css`, which the site's
   own vendored PhotoSwipe `static/css/main.css` shadows. Renamed to
   `scott.css`. File-name collisions across the theme/site boundary are a
   real thing.

### Constraints that held

The point of the exercise was a visual overhaul, not a reorganization, so:

- Every URL is byte-identical to before. The build produces the same 186
  URL entries as the pre-redesign build, verified by diffing the generated
  path set against the historical `public/` artifact (186 common, 0 new).
- No content files were touched.
- The build is still plain `hugo` - no Node, no bundler, no pipeline.

### Before and after

{{< figure src="/images/redesign-2026/before-post.png" caption="Before: Bootstrap 3 'Beg' theme" >}}
{{< figure src="/images/redesign-2026/after-post-light.png" caption="After: light scheme" >}}
{{< figure src="/images/redesign-2026/after-post-dark.png" caption="After: dark scheme" >}}
{{< figure src="/images/redesign-2026/after-gallery.png" caption="Gallery page, new thumb grid" >}}

Full notes, the theme inventory, and the verification logs are in the repo
at `docs/visual-redesign.md`, alongside the build-parity documentation from
the earlier build-stack modernization.
