# scotttactical

The Scott Tactical site - a static blog built with Hugo and served as a container.

## Stack

- **Hugo** - the static site generator (source site)
- **nginx** - serves the built output (via `nginxinc/nginx-unprivileged`)
- **Container image** on `ghcr.io/solvire/scotttactical` - the deployable artifact

The `Dockerfile` is a multi-stage build: it compiles fresh Hugo output, then
serves it through nginx. The deployed site runs this image.

## Local development

Prereqs: [Hugo](https://gohugo.io/installation/) (the version pinned in the
Dockerfile; see `Dockerfile`).

```bash
# run the dev server with live reload
hugo server

# build the static site into ./public
hugo
```

The `./public/` directory is the build output.

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

Add a post with:

```bash
hugo new post/your-name.md
```

Edit, then `hugo` to rebuild and `hugo server` to preview.

## License

Copyright (c) Scott Tactical. All rights reserved.