# Writing and Publishing Articles

How to write an article for scotttactical.com and get it live. Written to be
handed to a fresh workspace or a new editor with no prior context: everything
needed is in this file plus the repo itself.

- Repo: `github.com/solvire/scotttactical` (branch `master`)
- Working copy: `/media/master-store/Master_Documents/projects/scotttactical/scotttactical`
  (the ONLY checkout - do not create a second clone; GitHub is the backstop, and
  two local trees drift apart and cause confusion)
- Live site: https://scotttactical.com

---

## 1. What this site is

A static blog built with **Hugo**, rendered by the custom theme `themes/scott/`,
and served as a container image (`nginx` serving the built output). There is no
CMS, no database, and no runtime server-side code. An article is a Markdown file
committed to this repo; publishing means rebuilding the site and shipping a new
container image tag.

Three facts that shape everything below:

1. **No local toolchain.** Hugo runs in Docker. Never install Hugo, Go, or any
   build tool on the host (this repo lives on a NAS mount). See the `Dockerfile`
   and README.
2. **The Markdown file is the source of truth.** `public/` is generated output;
   do not hand-edit it.
3. **URLs are pinned in front matter.** The `url:` field IS the canonical URL.
   Never change an existing one.

---

## 2. Where articles live

| Section | Directory | URL shape |
|---|---|---|
| Blog posts (default) | `content/post/<slug>.md` | `/your-slug/` |
| News | `content/news/<slug>.md` | `/news/...` |

Put almost everything in `content/post/`. Use `content/news/` only for the
legacy news-style entries that already live there.

---

## 3. The article file (front matter contract)

Create `content/post/<slug>.md`. Copy the front matter shape from a recent post
(good templates: `content/post/moving-django-dtac-io-home.md`,
`content/post/self-hosting-the-mini-data-center.md`,
`content/post/site-redesign-2026.md`):

```yaml
---
date: 2026-09-23T12:00:00-07:00
draft: false
title: "From EC2 To My Desk: Moving a Django Site (dtac.io) Home"
url: /moving-django-dtac-io-home/
image: images/django-home-topology.jpg
categories:
  - Software
tags: [ django, postgres, self-hosting, homelab, k3s, frp, engineering, meta ]
comments: false
---
```

Field rules:

- **`date`** - MUST be before the build time. `buildFuture = false` in
  `hugo.toml`, so a future-dated post is **silently dropped** from the build (no
  error - the page simply is not there). This is the single most common
  publishing failure. Use `-07:00` (US Pacific) to match the rest of the site;
  the workstation's local timezone is irrelevant, the offset in the file is what
  counts. Pick a time comfortably in the past, not "midnight today" - a post
  dated `T00:00:00-08:00` is still in the future for the first hours of the UTC
  day and gets dropped.
- **`draft`** - set `false`. (`buildDrafts = true` is intentionally on so the
  older still-draft legacy posts keep rendering, but new posts should be `false`.)
- **`title`** - the headline, quoted.
- **`url`** - the URL pin. Format `/your-slug/`. This is load-bearing for SEO and
  existing links. New articles get a NEW pin; never reuse or change one.
- **`image`** - optional hero/social image, path relative to `static/`
  (e.g. `images/django-home-topology.jpg`).
- **`categories`** - list; usually `Software` (the site uses a small set).
- **`tags`** - inline list; reuse existing tags where they fit
  (`self-hosting`, `homelab`, `hugo`, `llm`, `ai`, `engineering`, `meta`, ...).
- **`comments`** - `true` enables Disqus on the post; `false` (the default for
  new posts) leaves it off.

Front-matter pre-flight (cheap, catches the date trap before a wasted build):

```bash
# the post date must be earlier than now, or the build drops the page silently
grep -m1 '^date:' content/post/<slug>.md
date -u +%Y-%m-%dT%H:%M:%SZ
```

The real guard is the build itself: after any build, the page directory must
exist (`ls /tmp/hugo-check/<slug>/`, or inside the deploy image). If it is
missing, the date is the first thing to check.

The body is Markdown. Raw HTML is allowed (the build has
`[markup.goldmark.renderer] unsafe = true`). Code fences are syntax-highlighted
by Chroma.

---

## 4. Voice and structure (match the house style)

Read one recent post end to end before writing - the site has a consistent
first-person, engineering-field-notes voice. Conventions the recent posts share:

- Open with a short **TL;DR** or a plain-spoken hook, not marketing.
- First person, concrete, "here is what I actually did and what broke."
- Real numbers and specifics (costs, sizes, timings, what went wrong).
- Short sections with `##` headers; generous code blocks.
- Close with the practical result and any caveats.

Do not invent facts. If a number is an estimate, label it as an estimate.

---

## 5. Images

- Put article images under `static/images/` (a `<topic>/` subfolder is fine, but
  flat is also used, e.g. `static/images/django-home-topology.jpg`).
- Reference them in the body either way - both render:
  - plain Markdown, `![alt text](/images/django-home-topology.jpg)` - what the
    recent posts use, or
  - the `figure` shortcode, when you want a caption:

```markdown
{{< figure src="/images/django-home-topology.jpg" caption="The rack as it stands today." >}}
```

- The `image:` front-matter field (a hero/social image) is separate from in-body
  figures and points at the same `static/` tree. A leading slash (`/images/x.jpg`)
  or none (`images/x.jpg`) both work; existing posts use both.
- Gallery images are a different mechanism (external host, `content/gallery/`) -
  not covered here.

---

## 6. Preview locally (Docker only)

A live-reload dev server with the repo mounted; rebuilds on every file save:

```bash
docker run --rm -v "$PWD":/site -w /site -p 1313:1313 \
  ghcr.io/gohugoio/hugo:latest \
  server --config hugo.toml --bind 0.0.0.0 --port 1313
```

Then open http://localhost:1313/ . Your new post is at
`http://localhost:1313/<slug>/`. If a dev server is already running on :1313,
check it first: `docker ps --filter publish=1313`.

---

## 7. Build and verify (before publishing)

Build to a scratch directory (never trust the working tree's `public/`):

```bash
docker run --rm -v "$PWD":/site -v /tmp/hugo-check:/out -w /site --entrypoint hugo \
  ghcr.io/gohugoio/hugo:latest --config hugo.toml --environment production \
  --destination /out --cleanDestinationDir
```

Verify:

1. The build prints a `Pages` count and no errors.
2. Your page exists: `ls /tmp/hugo-check/<slug>/`.
3. Visually confirm it renders (serve the scratch build and screenshot):

```bash
python3 -m http.server 13199 --directory /tmp/hugo-check &
google-chrome --headless --no-sandbox --hide-scrollbars --window-size=1440,2400 \
  --screenshot=/tmp/shot.png http://localhost:13199/<slug>/
```

Read the screenshot back to confirm layout, images, and code blocks look right.

4. **URL discipline:** diff the generated path set against the previous build to
   confirm no existing URL disappeared (baseline before the redesign was 186
   entries; a new post adds its page plus its tag term pages).

---

## 8. Publish / deploy

Publishing is a **container image** deploy (GitOps), not a file copy. The image
is built from this repo's `Dockerfile` (multi-stage: Hugo builds `public/`,
nginx serves it) and pinned by tag in the `homelab-manifests` repo, which ArgoCD
reconciles onto the k3s cluster.

**Operator approval is required before committing, pushing, or deploying.**

The sequence:

```bash
# 1. Build and push a NEW image tag (never reuse or overwrite a tag)
docker build -t ghcr.io/solvire/scotttactical:<new-tag> .   # prints the Pages count
docker login ghcr.io                       # classic PAT with write:packages
docker push ghcr.io/solvire/scotttactical:<new-tag>

# 2. Confirm the page is actually inside the image (catches the date trap)
docker run --rm --entrypoint sh ghcr.io/solvire/scotttactical:<new-tag> \
  -c 'ls /usr/share/nginx/html/<slug>/'

# 3. Bump the image reference in the deployment manifest
#    homelab-manifests/apps/scotttactical/deployment.yaml  -> image: ...:<new-tag>

# 4. Commit + push the manifest; ArgoCD converges the cluster
```

Current pinned tag: see `homelab-manifests/apps/scotttactical/deployment.yaml`
(was `0.2.5` as of this writing). Use a new semantic tag each publish
(`0.2.6`, `0.2.7`, ...); never `latest`, never reuse.

### Verify the rollout

ArgoCD auto-syncs, but its repo poll can lag a few minutes. (These commands
assume `kubectl` is already pointed at the home cluster.) Force a refresh if
you are impatient, then confirm the cluster is on the new tag and that ArgoCD
synced the exact commit you pushed:

```bash
# optional: make ArgoCD re-read the repo now instead of waiting for its poll
kubectl -n argocd annotate application scotttactical \
  argocd.argoproj.io/refresh=normal --overwrite

kubectl get deploy scotttactical \
  -o jsonpath='{.spec.template.spec.containers[0].image}'; echo   # -> :<new-tag>
kubectl rollout status deploy/scotttactical

# ArgoCD's synced revision must equal the manifest commit you just pushed
kubectl get application scotttactical -n argocd \
  -o jsonpath='{.status.sync.revision}'; echo
```

A first request can return `502` for a few seconds while the old pod terminates
- re-check rather than panic.

Notes:

- The `Dockerfile` regenerates `public/` on every build from source, so the
  committed `public/` tree is not the deploy artifact - the image is.
- The network path (Route53 -> hub frp tunnel -> home cluster -> pod) is
  documented separately in `docs/edge-deployment.md`. You do not touch it to
  publish content.
- Nothing in this repo exposes cluster addresses; the manifests repo owns
  deployment details.

---

## 9. Gotchas (do not rediscover these)

- **Future-dated post disappears.** `buildFuture = false` drops posts dated in
  the future, with no error. Set `date` in the past.
- **`markup.unsafe` is ignored by Hugo 0.166.** Raw HTML is enabled via
  `[markup.goldmark.renderer] unsafe = true` in `hugo.toml` (already set).
- **Theme CSS must not be named `main.css`.** The site's vendored PhotoSwipe
  `static/css/main.css` shadows it; the theme stylesheet is `scott.css`.
- **`ignoreLogs` must be top-level** in `hugo.toml`, not inside a table.
- **Light-scheme screenshots:** system Chrome prefers dark; force light with
  `--blink-settings=preferredColorScheme=1`.
- **macOS `._*` junk files** exist under `static/` and `public/`; ignore them.
- **Don't change an existing `url:` pin.** Verify no regressions by diffing the
  generated path set (section 7, step 4).

---

## 10. Checklist

- [ ] `content/post/<slug>.md` created with front matter copied from a recent post
- [ ] `date` is in the past, `draft: false`, `url` is a new unique pin
- [ ] `title`, `categories`, `tags`, optional `image` set
- [ ] Body written in the house voice; facts real, estimates labeled
- [ ] Images placed under `static/images/<topic>/` and referenced with `figure`
- [ ] Previewed at `http://localhost:1313/<slug>/`
- [ ] Production build passes; page exists; screenshot verified
- [ ] No existing URL disappeared in the path-set diff
- [ ] Operator approved commit/push/deploy
- [ ] Image built + pushed with a NEW tag; page confirmed inside the image
- [ ] Manifest bumped; ArgoCD synced revision matches the pushed commit
- [ ] `kubectl rollout status deploy/scotttactical` succeeds; pod on the new tag
- [ ] Live check: `curl -sI https://scotttactical.com/<slug>/` returns 200
