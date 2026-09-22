# scotttactical visual redesign - theme "scott"

Date: 2026-09-22
Repo: github.com/solvire/scotttactical
Scope: visual redesign only. The build stack was modernized earlier the same
day; see `docs/build-and-url-parity.md`. No content, URL, or config-structure
changes beyond what is listed here.

## What changed

1. New theme `themes/scott/` replaces `hugo_theme_beg` as the active theme
   (`hugo.toml`: `theme = "scott"`). The old theme directory is untouched and
   remains in the repo for rollback.
2. The new theme is hand-rolled: no Bootstrap, no jQuery, no Font Awesome, no
   external asset requests of any kind (fonts are the system stack).
3. Dark + light color schemes via CSS custom properties and
   `@media (prefers-color-scheme: dark)`. No JS toggle.
4. Syntax highlighting is now server-side Hugo Chroma. `hugo.toml` gained
   `[markup.highlight]` (`noClasses = false`); the stylesheet is
   `themes/scott/static/css/chroma.css` (generated once with
   `hugo gen chromastyles --style=solarized-dark`).
5. All dead CDN references are gone from rendered pages:
   `maxcdn.bootstrapcdn.com` (Bootstrap CSS/JS, Font Awesome),
   `cdnjs.cloudflare.com` (highlight.js 8.4), `code.jquery.com`,
   `yandex.st` (the ancient `default_foot.html` partial). Verified with a
   recursive grep of the built site: zero matches for those hosts, for
   `glyphicon`, and for `highlight.js`/`bootstrap.min`/`font-awesome`.
6. Site-level layouts restyled to the new design system (they override the
   theme, so they had to be updated in place):
   - `layouts/404.html` (was raw Bootstrap markup with an off-site
     "Contact Support" button; now a themed 404 using baseof blocks).
   - `layouts/gallery/{list,li,single,gallery}.html` (Bootstrap grid and
     glyphicon removed; PhotoSwipe markup contract preserved).
   - `layouts/partials/gallery/schema.html` (inline `<style>` moved into the
     theme CSS; thumbs are now `loading="lazy"`; still renders from front
     matter against `Params.GalleryBaseUrl`).
7. `hugo.toml` config fixes discovered during verification:
   - `markup.unsafe` is not honored by Hugo 0.166; raw HTML in old posts was
     being silently omitted (12 occurrences in one post). Moved to the modern
     `[markup.goldmark.renderer] unsafe = true`. Build now renders all raw
     HTML; zero `raw HTML omitted` comments in output.
   - `ignoreLogs` had been nested inside the `[markup]` table (it must be
     top-level); hoisted. The raw-HTML warnings are gone regardless since the
     underlying omission bug is fixed.
8. Theme CSS is `themes/scott/static/css/scott.css` - NOT `main.css`. The
   site's own `static/css/main.css` (vendored PhotoSwipe) shadows a same-named
   theme file, which produced an unstyled first build. Renamed to avoid the
   collision.

## Theme inventory

    themes/scott/
    ├── theme.toml
    ├── layouts/
    │   ├── 404.html
    │   ├── _default/{baseof,list,single,summary,li,li_sm,terms}.html
    │   ├── partials/{meta,header,footer,sidebar,pagination,single_meta,single_json_ld}.html
    │   └── shortcodes/{img,clear}.html
    └── static/css/{scott.css,chroma.css}

Design system: fluid type scale (`clamp()`), ~68ch article measure, 16rem
sidebar that stacks below content under 900px, sticky header, pill-style
taxonomy terms, CSS-grid gallery thumbs (`aspect-ratio: 1`, lazy loading),
dark-aware code blocks (solarized-dark Chroma palette reads in both modes).

Unchanged on purpose: Disqus + Google Analytics snippets (still gated on
`Params.Disqus`/`Params.GoogleAnalyticsUserID`, carried over verbatim from
the beg baseof), vendored PhotoSwipe assets, `buildDrafts = true`,
`paginate = 3`, all menu entries, all content files.

## Verification

- Build: `docker run --rm -v "$PWD":/site -v <out>:/out -w /site --entrypoint hugo ghcr.io/gohugoio/hugo:latest --config hugo.toml --environment production --destination /out --cleanDestinationDir`
  succeeds with zero warnings. 187 pages / 186 URL entries / 10 paginator
  pages / 40 aliases - identical counts to the pre-redesign build.
- URL parity vs the live `public/` artifact (same method as the parity doc):
  OLD 299, NEW 186, COMMON 186, LIVE-ONLY 113, NEW-ONLY 0. The new URL set is
  an exact subset of the historically-live paths; the 113 legacy-only paths
  are the same drops documented in `build-and-url-parity.md`.
- HTTP smoke test on the built output: 200 on `/`, `/about/`, `/news/`,
  `/post/`, `/gallery/`, `/tags/`, a post, a news permalink, `/404.html`,
  `/css/scott.css`, `/css/chroma.css`.
- Chroma markup present in code-fenced posts; `chroma.css` served.
- Visual check via headless Chrome screenshots (light, dark, mobile widths)
  of home, post, code-heavy post, news, gallery list, gallery single, tags.

## Screenshots (docs/redesign-screenshots/)

| File | What |
|---|---|
| `before-home.png` / `before-post.png` | Old beg theme (Bootstrap 3 look) |
| `light-home.png` / `light-post.png` | New theme, light scheme |
| `light-gallery.png` | Gallery single with thumb grid |
| `light-code.png` | Code-heavy post, Chroma blocks |
| `light-news.png` / `light-tags.png` | News list / taxonomy terms |
| `dark-home.png` / `dark-post.png` / `dark-gallery.png` | Dark scheme |
| `mobile-home.png` | 390px width, stacked layout |

## Rollback

`hugo.toml`: set `theme = "hugo_theme_beg"` and remove the
`[markup.highlight]` block (keep `[markup.goldmark.renderer] unsafe = true` -
that fixes a real rendering bug independent of the theme). The beg theme is
unmodified, so no other rollback steps are needed.

## Out of scope (unchanged)

- Gallery image hosting (`img.scotttactical.com` over plain http) - separate
  S3/Cloudflare session. Rendering does not hard-block on that host.
- No commit/push/deploy performed.
