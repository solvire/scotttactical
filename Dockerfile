# Multi-stage build: compile a fresh Hugo site, serve only the new output.
#
# Stage 1 - build
#   Pin the Hugo version by image digest for a reproducible build. The renderer
#   must be the extended (withdeploy) build so syntax highlighting and SCSS/asset
#   features behave. Rebase onto a newer gohugoio/hugo tag to upgrade Hugo.
FROM ghcr.io/gohugoio/hugo:latest AS builder

USER root

COPY . /site
WORKDIR /site

# Run the build as root: the gohugoio/hugo image runs as uid 1000 but the
# COPY would leave /site root-owned. The builder only emits /site/public,
# so root ownership here is safe. buildDrafts is ON so the generated URL
# set keeps the live pages (several live posts are still marked draft).
RUN hugo --environment production --cleanDestinationDir \
    --config hugo.toml --minify

# Stage 2 - serve
#   nginx-unprivileged serves ONLY the freshly built output. No prebuilt
#   public/ is copied; the artifact is regenerated on every image build.
FROM nginxinc/nginx-unprivileged:1.27-alpine

COPY --from=builder /site/public /usr/share/nginx/html/
COPY nginx-default.conf /etc/nginx/conf.d/default.conf

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s CMD wget -qO- http://127.0.0.1:8080/ || exit 1