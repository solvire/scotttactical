---
date: 2026-09-22T15:00:00-07:00
draft: false
title: "Welcome Home... To My Home - From Cloud To Self-Hosting"
url: /self-hosting-the-mini-data-center/
image: images/minidc-topology.jpg
categories:
  - Software
tags: [ self-hosting, llm, ai, k3s, homelab, engineering, meta ]
comments: false
---

It started with this website here. For years this site sat on an AWS EC2 instance, with S3 hosting some images. It cost around $4/mo so it wasn't much. But I got to thinking about it. Within that year I could have paid for a little machine. With about 10X the power. Literally. And it was even more than that. It was remote, and static, and hard to update, which meant it was stale. As you can see by the posts it was very stale. Then we start expanding that math to the bigger sites I had. Then it hit me pretty hard. I'm just burning money.

Now it's local. Sitting on my desk. And proxied out through my firewall. And when I am working with a coding harness I can push button deploy new articles. This is great. My tech-nerd-CTO footprint was far too small anyway. I needed to publish more about the side tasks I was working on. Things like that. 

## TL;DR

The short version: I was paying around $95 a month to host a pile of small things
in the cloud, most of which I barely used. This site was a tiny slice of that. I
wanted the whole footprint consolidated onto hardware I own, running at home, for
under $20 a month. An AI agent made the setup cheap enough that it was finally
worth doing.

This is the record of standing that up. No fluff.

Here's what we're talking about before the details - the rack as it sits today:

![The phase-0 topology](/images/minidc-topology.jpg)

## The numbers

| Item | Cost |
|---|---|
| Node (used Tiny) | ~$234 one-time |
| Router | ~$120 one-time |
| UPS battery replacement | $55 one-time |
| Agent-token cost for the whole effort | ~$25 |
| Recurring before | ~$95/mo |
| Recurring after (goal) | under $20/mo |
| Phase 0 ROI | under 6 months |

The one-time hardware plus a handful of dollars in agent tokens replaces a
recurring bill that never stopped. And the capacity story is the honest part:
I'm not trying to replicate the rented boxes. The cluster buys a node when the
migration needs one, so it never idles capacity the way the rented fleet did.

## The starting point

Mostly already-owned or used hardware:

- A **TrueNAS** tower - storage and the backup target
- A **Raspberry Pi 4** - the ops controller (SSH door into the cluster)
- A **Raspberry Pi Zero** - Pi-hole DNS and the UPS controller
- A **Lenovo M720q Tiny**, bought used - the cluster node
- A MikroTik router, an APC UPS (with a battery I replaced), some networking gear

The intended node was an ODROID-H5, but it got tariff-delayed, so the used Tiny
stands in. The cluster will grow with an H5 or another Tiny when the next batch
of sites migrates.

## The stack

- **k3s** on the node, **Traefik** for ingress
- **ArgoCD** - GitOps; git push is the deploy
- **opslayer** - a small control layer (CLI + MCP) over the operations
- **frp** for public exposure - the box dials out, so zero ports open on the house
- **NUT** for UPS shutdown ordering
- **Route53** for DNS

![The rack as it sits](/images/rack-hardware.jpg)

The topology as it actually sits today:

{{< mermaid >}}
flowchart LR
    WAN["Internet"] --- R["L009 router<br/>edge + DNS -> pihole"]

    subgraph rack["The rack (on ups01)"]
        UP1["APC UPS<br/>ups01"]
        PZ["Pi Zero<br/>Pi-hole DNS + NUT master"]
        P4["Pi 4<br/>ops01: ops controller"]
        NAS["TrueNAS<br/>storage + backup target"]
        N00["M720q Tiny<br/>node00: k3s"]
        UP1 --- PZ
        UP1 --- P4
        UP1 --- NAS
        UP1 --- N00
        R --- PZ
        R --- P4
        R --- NAS
        R --- N00
    end

    N00 ---|"frpc dials OUT"| E["edge box<br/>frps + TLS"]
    E --- WAN
{{< /mermaid >}}

## What actually took effort

The happy path is boring. The real work was the parts that look easy on a diagram:

- **Making the tunnel reach the edge.** The frp control port was silently blocked
  by the cloud security group, which crash-looped the client. Opened it. Then the
  web server had no certificate for the domain and served the wrong virtual host.
  Fixed. Then the ingress wouldn't route the hostname until we rewrote the Host
  header. Three separate, mundane, real problems.
- **ArgoCD install quirks.** Cluster CRDs needed `--server-side` apply; a repo
  URL scheme mismatch (HTTPS vs SSH) failed silently as "repository not found."
- **Node-day gotchas.** The installer under-allocated the disk volume; a
  cloud-init file silently re-enabled password SSH and had to be deleted.
- **Ops discipline.** UPS shutdown ordering, and backups that are actually
  restored on a schedule instead of just scheduled.

None of this is exotic. That's the point - it's the normal, unglamorous work of
running infrastructure, and it's exactly the kind of work an AI agent absorbs.


## The broader goal

It isn't just compute. The same consolidation applies to file sync, photo
backup, notes, a password manager, monitoring - each a separate recurring bill
today, each a candidate to move home. The NAS becomes the single local sink
instead of every service keeping its own cloud copy.

![The consolidation: many rented boxes to one owned rack](/images/minidc-consolidation.jpg)

The shift is simple: stop renting weak compute and storage a few dollars at a
time, and collapse it onto hardware you own, bought used, run locally - with an
agent absorbing the setup work that used to make it not worth bothering.