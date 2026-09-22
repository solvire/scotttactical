# scotttactical

The Scott Tactical site - a static blog built with Hugo and served as a container.

## Stack

- **Hugo** - the static site generator (source site), theme `themes/scott/`
- **nginx** - serves the built output (via `nginxinc/nginx-unprivileged`)
- **Container image** on `ghcr.io/solvire/scotttactical` - the deployable artifact

The `Dockerfile` is a multi-stage build: it compiles fresh Hugo output, then
serves it through nginx. The deployed site runs this image.

## No local toolchain required

Do NOT install Hugo, Go, or any other build toolchain on the host (this repo
lives on a NAS mount). Everything runs through the official Hugo container
image:

```bash
# dev server with live reload on http://localhost:1313
docker run --rm -v "$PWD":/site -w /site -p 1313:1313 \
  ghcr.io/gohugoio/hugo:latest \
  server --config hugo.toml --bind 0.0.0.0 --port 1313

# one-off build into ./public
docker run --rm -v "$PWD":/site -w /site \
  ghcr.io/gohugoio/hugo:latest \
  --config hugo.toml --environment production --cleanDestinationDir
```

The `ghcr.io/gohugoio/hugo` image contains the Hugo binary - Hugo is a single
statically-linked executable, so no Go installation is ever involved.

## Build and push the image

```bash
docker build -t ghcr.io/solvire/scotttactical:<tag> .

# authenticate ghcr.io (a classic PAT with write:packages scope)
docker login ghcr.io

docker push ghcr.io/solvire/scotttactical:<tag>
```

Use a **new semantic tag** for every publish (e.g. `0.2.0`, never `latest`).
Deploys are pinned to an explicit tag, so don't overwrite an existing tag.

## Deploy

The image is deployed to the homelab k3s cluster via ArgoCD (GitOps). Deployment
manifests live in the `homelab-manifests` repo. A publish is:

1. Build + push a new image tag (above)
2. Bump the image reference in the deployment manifest
3. ArgoCD converges the cluster

Nothing here exposes the cluster or its addresses; the manifests repo owns the
deployment details.

## Content

Add a post by creating a file under `content/post/your-name.md` (front matter
conventions in any existing post), or scaffold it with:

```bash
docker run --rm -v "$PWD":/site -w /site \
  ghcr.io/gohugoio/hugo:latest new post/your-name.md
```

Edit, then rebuild with the Docker commands above to preview.

## Docs

- `docs/build-and-url-parity.md` - build-stack modernization + URL stability proof
- `docs/visual-redesign.md` - the `themes/scott/` redesign: decisions,
  verification, before/after screenshots, rollback instructions

## License

Copyright (c) Scott Tactical. All rights reserved.