# Serve the prebuilt hugo public/ output.
# NOTE (2026-09-17): this site is hugo <=0.19-era (CamelCase config, vendored
# hugo_theme_beg theme, gulp-3 less). Modern hugo will NOT build it as-is.
# Two paths, deliberately split:
#   - now:     serve the existing public/ as-is (this Dockerfile)
#   - follow-up: pin a period-correct hugo in a build stage and regenerate
# Revisit before content changes; do not let this note rot.
FROM nginxinc/nginx-unprivileged:1.27-alpine

COPY nginx-default.conf /etc/nginx/conf.d/default.conf
COPY public/ /usr/share/nginx/html/

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s CMD wget -qO- http://127.0.0.1:8080/ || exit 1
