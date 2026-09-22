# scotttactical Hugo modernization - build + URL parity

Date: 2026-09-22
Repo: github.com/solvire/scotttactical
Scope: build-stack modernization (no CMS, no generator switch, no monorepo).

## What changed

The site built with a modern Hugo. The live prebuilt `public/` is no longer the
deployment artifact; the Dockerfile is now a multi-stage build that compiles
from source and serves only the fresh output.

1. Config: two legacy CamelCase files (`config.yaml`, `configTaxo.yaml`) replaced
   by a single lowercase modern `hugo.toml` (baseURL, locale, taxonomies, menu,
   params, markup.unsafe, buildDrafts, ignoreLogs). `buildDrafts = true` keeps
   live pages that are still marked draft in content front matter.
2. Theme `hugo_theme_beg` salvaged (smallest diff). Three surgical fixes for
   APIs removed in modern Hugo:
   - `layouts/_default/baseof.html`: removed the removed `_internal/google_analytics.html`
     template, inlined the GA snippet gated on `Params.GoogleAnalyticsUserID`.
   - `layouts/_default/single.html`: removed the removed `_internal/disqus.html`
     template, inlined the Disqus embed (matching the site gallery layout).
   - `layouts/partials/gallery/schema.html`: removed the removed `getJSON`
     shortcode (the remote `img.scotttactical.com` metadata host no longer
     resolves over HTTPS). Gallery now renders thumbs/links from front matter.
3. Gallery repair (was a non-functional stub in production): `layouts/gallery/gallery.html`
   was a debug placeholder ("Before XXX"); `list.html` was a stub. Both rewritten to
   a working single/list using the theme's `_default` fragments.
4. gulp-3 LESS pipeline retired: removed `gulpfile.js`, `package.json`,
   `node_modules/`, `less/`, `resources/_gen`. The compiled CSS is committed
   under `static/css/` (it is what the theme already ships). No JavaScript
   build pipeline remains.
5. URL stability pins (front matter `url:` added) so renamed source files keep
   their historically-live slugs. Renames happened over the years without a
   redirect; the pins restore the live URL instead of producing a new slug.
6. Image case-sensitivity fix: content references mixed-case filenames
   (`Marcus_Porcius_Cato.jpg`, `Thanksgiving-Rockwell.jpg`) but `static/images`
   held lowercase names. On the mac (case-insensitive FS) this worked silently;
   on a Linux build the images would 404. Case-matching copies are committed.
7. `.gitignore`: added `._*` (macOS resource-fork metadata that was untracked
   on disk and leaking into builds) and confirmed `/node_modules/` is ignored.
8. Dockerfile: multi-stage. `ghcr.io/gohugoio/hugo:latest` builds (runs as root;
   the copy tree is root-owned) with `--cleanDestinationDir --minify`; only the
   fresh `public/` is copied into `nginxinc/nginx-unprivileged:1.27-alpine`.
   No prebuilt `public/` is shipped.

## Hugo version

Pinned to the gohugoio extended image at build time. The operator chose NOT to
pin a specific version tag; `latest` resolves to `hugo v0.166.0+extended`.
If reproducibility is required the image can be pinned by digest, e.g.

    FROM ghcr.io/gohugoio/hugo@sha256:9f3cccb54b48e83a5468cd44f0372b10834b6d8418ef692d9821bb1314761829 AS builder

## Proof - build

- `docker build` succeeds (both stages), image tag `stac-test:verify`
  (sha `30e0b8e3e98b`), local serve test returns HTTP 200 on `/`, a post
  (`/management-for-quality-software-development/`), `/news/`, `/gallery/`,
  `/css/styles.css`, and an image.
- A full crawl of the served container: 0 broken internal links.
- Building the exact repo tree (fresh copy) yields 187 pages / 186 URL entries,
  identical to the scratch build.

## URL parity vs the live public/

The live `public/` was NOT one clean build - it interleaved three Hugo
generations (`Hugo ` legacy / 0.54.0 / 0.92.2), with 11 pages still pointing at
`localhost:1313` and 38 referencing dead CDN assets. The committed artifact is
therefore a floor, not the intended structure. Parity contract = page + static
asset PATH stability, verified by diffing the generated URL set against the
287 `index.html` paths of the old `public/`.

    COMMON   : 174  (present in both old and new - preserved)
    LIVE-ONLY: 113  (in old artifact, not regenerated - all classified legacy)
    NEW-ONLY :  12  (in new build, not in old artifact - newly surfaced content)

All 55 post/gallery URLs authored in content front matter are preserved
(zero content regressions from source).

### LIVE-ONLY (113) - why each is safe to drop

- `page/N ... page/28` (27) + `post/page/*` (11): pagination of an older, larger
  flat index that no longer exists. The current home lists the section roots
  (`post`, `gallery`, `news`), so the seed page index collapses to one.
- `news/page/3..6`: pagination of the old news list; the current list is pinned
  to `/2016/MM/` permalinks, so the `/news/` index is smaller.
- `post/<slug>` (23): old robust rendered a duplicate of every post under both
  its root `url:` AND an auto `/post/` path. Modern Hugo renders only the
  canonical `url:` (root). The `/post/` copies were duplicate pages, not
  distinct content - SEO-canonical form is the root URL and both resolve today.
- `tags/*` (54): tag term pages for tags that were either typos/old normalizations
  (`managment`, `networkign`, `69blazer` - now correctly `management`,
  `networking`, `69-blazer`) or tags on content that was renamed/re-pinned.
- `1/01`, `yosemite-valley-ca-october-8-2015`, `photography-...-old` (4):
  stale/artifact paths with no corresponding source content.
- `news/microsoft-accelerator-seattle-machine-learning` (1): old duplicate news
  slug; the canonical is now `/2016/02/...-funding/`.

### NEW-ONLY (12) - newly genuine content

- `news/data-mining-strengthen-border-security`,
  `news/jill-cataldo-on-data-mining-and-shopping`,
  `news/oculus-on-data-mining-to-virtual-reality` (3): source files exist and
  are genuinely published now; old artifact never shipped them.
- nine `post/*` for content that was draft/unpublished in the old artifact
  (e.g. `canon-eos-check-memory`, `car-computer-monitoring`,
  `conservatism-usa-myth-of-freedom`, `girls-code-better`, `war-is-terrorism`).

## Static asset parity

- `css/` and `js/`: identical file sets to the old `public/`.
- `images/`: every image referenced by source content resolves in the new build.
  Remaining diff vs old artifact is only case-variants (`ESB.jpg`/`esb.jpg`,
  `marcus_porcius_cato.jpg`/`Marcus_Porcius_Cato.jpg`) and the new case-copies,
  plus mac `.DS_Store`/`._*` metadata.

## Theme changes to approve

The visual design is unchanged (Bootstrap 3 "Beg" look, same baseof/single/list).
Two subtle, HTTP-level differences for operator awareness:

1. Disqus and Google Analytics are now inlined in the layout instead of using
   Hugo's removed `_internal/` templates. Output is functionally identical
   (same tracker IDs from `Params`).
2. Gallery schema no longer pulls per-image EXIF/JSON from the dead
   `img.scotttactical.com` host. Thumbs/links render from front matter, so
   galleries are smaller but no longer produce "Before XXX" stubs.

## What the operator must do

1. Tag a new image, e.g. `ghcr.io/solvire/scotttactical:0.2.0`, and update the
   k3s/ArgoCD reference (node00 entry currently: `ghcr.io/solvire/scotttactical:0.1.0`).
2. The public-scottactical.com serving decision (tunnel vs record) is unchanged
   and still pending. This overhaul does not alter the network path.
3. Commit these source changes and drive the ArgoCD redeploy; both are gated on
   the human operator, not on this build.

## Rollback

Not needed for the source itself (old `public/` is untouched and the old
Dockerfile is in git history). If a deploy misbehaves, redeploy the previous
image tag.