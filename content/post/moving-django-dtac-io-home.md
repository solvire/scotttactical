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

The last big cloud holdout I had was a Django site on an AWS EC2 box. You are
reading this one, the Hugo site, from the same desk now - but dtac.io was the one
that had an actual database in it. That made it the interesting one. This article
is the record of dragging a real, stateful web application off a rented VM and
onto the little cluster sitting next to my keyboard.

## TL;DR

dtac.io was a cookiecutter-Django site living on a single EC2 instance with its
own local Postgres. The site itself was small - an information site, a few pages,
a handful of users - but it was a real Django app: gunicorn, migrations, a
relational database, the whole thing. The previous article covered the static
Hugo site; this one is the same move, except the thing I had to carry was a
database, not a directory of HTML. Capture the DB, rebuild the image, restore
into the cluster's Postgres, and cut DNS over the same frp edge. Zero inbound
ports, zero CNAME-at-apex problem, DNS stayed on Route53.

![The path: dtac.io through the edge, into the home cluster](/images/django-home-topology.jpg)

## Why this one was different

Moving the Hugo site was mostly shuffling static files. Moving a Django site is
moving a process and its memory. Three things are genuinely different when the
site is Django:

- **There is state to move, and it is the database.** The git tree is only half
  the site. The other half - users, content, migration history - lives in
  Postgres. The one irreplaceable artifact is a `pg_dump`, not a tarball.
- **The app does not just get copied; it gets rebuilt.** Django needs its
  dependencies to resolve against a real Python version, and the version of every
  transitive package is decided at build time. That is where the pain lives.
- **It has to keep talking to a database at runtime.** The cluster needed a
  Postgres pod that held the restored data, and the app pod needed to reach it by
  name. No database, no site.

None of that is exotic. It is just the normal weight of a stateful web app, and it
is exactly the kind of work an agent is good at absorbing.

## The stack it landed on

The same edge and cluster from the earlier post:

- **k3s** on the node, **Traefik** for ingress
- **ArgoCD** - git push is the deploy
- **frp** for public exposure - the box dials out, so zero ports open on the house
- **Postgres 16** in-cluster on the node's local disk (not the NAS - a compromised
  site never touches the backup tier)
- **Route53** for DNS

{{< mermaid >}}
flowchart LR
    PUB["https://dtac.io"] --> RT53["Route53 A record"]
    RT53 --> HUB["edge box (hub)<br/>nginx TLS + frps"]
    HUB -->|"frp tunnel, dials out"| TR["home Traefik"]
    TR --> FE["fartemis pod<br/>gunicorn"]
    FE --> PG["fartemis-db pod<br/>Postgres 16"]
{{< /mermaid >}}

## Capture, rebuild, restore, cutover

The recipe was the same four moves as before, with the database carrying the extra
weight:

1. **Capture.** A `pg_dump` off the EC2, pulled to the workstation, verified
   (16KB gzipped - it really is a small site). The Postgres major version was the
   one fact that mattered, so the cluster DB image would match and the dump would
   restore clean.
2. **Rebuild.** Clean master, a production Dockerfile, and a rebuild of the image
   after two real bugs. One was Django's own doing: a `fido2` version - pulled in
   transitively by django-allauth - dropped an API the app imports, so celery
   crashed at startup. The fix was pinning `fido2==1.1.2`. The other was the
   build-time `compilemessages` step needing email env vars that had no defaults.
3. **Restore.** Stream the dump straight into the cluster's Postgres pod. Fifty-four
   tables, a single user, the full migration history. No intermediate copy on the
   node's metal.
4. **Cutover.** Same as the static site: repoint the `dtac.io` A record at the hub,
   add the nginx vhost + cert, register the frp route. DNS flips last so the old
   EC2 keeps serving until the tunnel is proven.

## Where Django made it different (the actual effort)

This is the part that looks easy on a diagram. Each one is a mundane, real problem,
and each one is specifically a Django-adjacent one:

- **The entrypoint got skipped.** The image's entrypoint builds `DATABASE_URL` from
  environment variables. ArgoCD's `command:` override bypassed it, so the app
  booted and immediately failed: "Set the DATABASE_URL environment variable."
  Fix: put the full connection string in the k8s Secret and reference it directly,
  instead of trusting the entrypoint to assemble it.
- **A transitive dependency broke celery.** `django-allauth` requires `fido2`, and
  pip happily resolved the newest `fido2` (2.x) - which removed the webauthn API
  the app imports. Django's system check crashed celery at startup. Pin `fido2`
  below 2.x and it goes away.
- **The readiness probe fought ALLOWED_HOSTS.** The probe hits a static path, but
  Django's `SecurityMiddleware` checks the Host header before anything else can
  serve it, and the probe's Host (a pod IP) is not in `ALLOWED_HOSTS`. For a
  no-nginx app the clean answer was to drop the probe and rely on process-based
  health.
- **TLS redirect loop.** Through the frp http tunnel the app believes it is on
  plain http, so `SECURE_SSL_REDIRECT` fired and bounced every visitor to the
  internal hostname. Since the edge already terminates TLS and does the http-to-
  https redirect, the app's own redirect had to be turned off.

None of this is exotic. That is the whole point - it is the ordinary friction of
running a Django app, and an agent turns that friction from a weekend into an
afternoon.

## The result

`https://dtac.io` now serves from the cluster on my desk: a Django app, a real
Postgres database, over a tunnel that dials out so the house opens no inbound
ports. The old EC2 stays on purely as a rollback - repoint the DNS record and it
is as if nothing happened. The monthly bill for that VM is gone, and the site is
faster to work on than it ever was in the cloud.

The static site proved the pattern. The Django site proved it holds weight.
Next up is mail.

![The rack](/images/rack-hardware.jpg)