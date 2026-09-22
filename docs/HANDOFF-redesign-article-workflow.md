# Handoff: how the redesign article + pages were produced

Date: 2026-09-22. Paste-ready handoff for future sessions.

## State

Visual redesign complete in the working tree. Theme `themes/scott/` active
(`theme = "scott"` in hugo.toml); `themes/hugo_theme_beg/` untouched for
rollback. Docs: `docs/visual-redesign.md`, `docs/build-and-url-parity.md`.
Screenshots: `docs/redesign-screenshots/`. Nothing committed or pushed.

## Recipe: creating an article

1. Create `content/post/<slug>.md`:

```yaml
---
date: 2026-09-21T18:00:00-07:00   # MUST be in the past - buildFuture=false drops future-dated posts silently
draft: false
title: "Your Title"
url: /your-slug/                  # URL pin - canonical URL, every post has one
categories: [ Software ]
tags: [ hugo, design ]
comments: false                   # true enables Disqus
---
```

Template example: `content/post/site-redesign-2026.md`.

2. Images: `static/images/<topic>/`, referenced with
   `{{< figure src="/images/<topic>/<file>" caption="..." >}}`.

3. Build + verify (Docker only - never install Hugo/Go on the host; the repo
   lives on a NAS mount):

```bash
docker run --rm -v "$PWD":/site -v /tmp/hugo-check:/out -w /site --entrypoint hugo \
  ghcr.io/gohugoio/hugo:latest --config hugo.toml --environment production \
  --destination /out --cleanDestinationDir
```

Confirm the `Pages` count, `ls /tmp/hugo-check/<slug>/`, then serve +
screenshot and read the image back to verify visually:

```bash
python3 -m http.server 13199 --directory /tmp/hugo-check &
google-chrome --headless --no-sandbox --hide-scrollbars --window-size=1440,2400 \
  --screenshot=/tmp/shot.png http://localhost:13199/<slug>/
```

4. Preview server: a Hugo container with the repo live-mounted runs on :1313
   and rebuilds on file change. Check:
   `docker ps --filter publish=1313` and
   `curl -s http://localhost:1313/ | grep -o 'css/[a-z]*\.css'`
   (expect scott.css + chroma.css).

5. URL discipline: never change an existing `url:` pin. Verify no regressions
   by diffing index.html path sets (baseline: 186 entries pre-redesign, 190
   after the redesign post).

## Gotchas (do not rediscover)

- `markup.unsafe` is ignored by Hugo 0.166; use
  `[markup.goldmark.renderer] unsafe = true` (already in hugo.toml).
- Theme CSS must not be named `main.css` - the site's vendored PhotoSwipe
  `static/css/main.css` shadows it. Theme CSS is `scott.css`.
- `ignoreLogs` must be top-level in hugo.toml.
- Light-scheme screenshots: force with `--blink-settings=preferredColorScheme=1`
  (system Chrome prefers dark).
- `static/` and `public/` contain macOS `._*` junk files; ignore them.

## Deploy (operator approval required)

`docker build -t ghcr.io/solvire/scotttactical:<tag> .`, push, bump the tag in
the homelab-manifests repo, ArgoCD converges. Never reuse a tag.
