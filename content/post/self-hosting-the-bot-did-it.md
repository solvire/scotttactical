---
date: 2026-09-22T21:15:00-07:00
draft: false
title: "How I Moved This Site Home (and Let a Bot Do It)"
url: /self-hosting-the-bot-did-it/
image: images/selfhost-hero.jpg
categories:
  - Software
tags: [ self-hosting, llm, ai, k3s, homelab, meta, engineering ]
comments: false
---

For years this site sat on a rented server in the cloud. It worked fine. It cost
a little money every month, and honestly I didn't think much about it. Then I
built out a small home rack and realized I was paying for compute I already owned
and just... letting it sit there idle at night.

So I did what any reasonable person with a tiny Kubernetes cluster and way too
much time does. I tried to move the whole thing home. And this time, an AI coding
agent did most of the heavy lifting.

## The premise

I did not want to open a single firewall port. That was the whole rule.

Buying a server at home and putting it on the internet the "classic" way means
forwarding ports on your router, messing with dynamic DNS, and hoping your ISP
doesn't block the whole idea. Residential ISPs love doing that. I wanted none of
it. The tunnel had to dial **out**, never in.

That one sentence drove every decision after it.

## What the setup looks like

There's a small node at home running Kubernetes. In front of it sits a cheap
always-on box that acts as the rim of the network - it terminates TLS, answers
DNS, and runs a tiny tunnel listener. Nothing at home is reachable from the
internet directly. The home node reaches *out* to that rim, and the rim hands
traffic it receives for a domain name back down that connection.

Public traffic never touches the home router. Zero ports opened. The home rack
is basically invisible from the outside.

Here's the shape of it, roughly:

{{< mermaid >}}
flowchart LR
    subgraph Internet
        U[Visitor] --> DNS[DNS at registrar]
        DNS --> E[Edge box]
        E -- "TLS termination" --> W[Web server on edge]
    end
    subgraph Home
        N[K8s node] -. "tunnel (outbound only)" .-> W2[Edge tunnel listener]
        W -- "tunnel payload" --> N
        N --> S[Site pod]
    end
{{< /mermaid >}}

No IPs in that diagram on purpose. The whole arrangement is: the edge box is the
only public face, the home node reaches out to it, and nothing inbound opens.

## How the workflow went

I was the one making the decisions. The agent did the execution. It was a
genuine division of labor, and honestly the first time the workflow felt like
pair programming with someone who never complains and has an encyclopedic memory
of exactly what needs to change.

The rough flow:

{{< mermaid >}}
flowchart TD
    A[Plan it on paper] --> B[Bootstrap the edge box]
    B --> C[Set up the tunnel server]
    C --> D[Terminate TLS / certs]
    D --> E[Point DNS at the edge]
    E --> F[Deploy the tunnel client at home]
    F --> G{Does the site load?}
    G -- "No" --> H[Diagnose + fix]
    H --> F
    G -- "Yes" --> I[Verify + harden]
    I --> J[Done]
{{< /mermaid >}}

It was not one clean straight line. That's the honest part. We hit three genuine
failure modes, and each one was a real lesson, not a typo:

- First, the edge web server had no certificate configured, so anyone hitting
  the domain got a blank page from the wrong virtual host. Fix: issue the cert.
- Then the tunnel came up but returned a 404, because the hostname the browser
  sent wasn't the one the home router was configured to answer. Fix: rewrite the
  host header at the tunnel.
- Then the client crashed-loop, unable to reach the edge at all - because the
  box's security group didn't allow the tunnel port through. Fix: open that one
  inbound rule on the rented box (the *only* port that opened, and it's on the
  rim, not the home router).

Each failure was mundane. Each taught me a little more about how the pieces fit.

![The bot doing the heavy lifting](/images/selfhost-bot.jpg)

## What the bot actually cost

Here's the part people always ask about. This entire project - moving the site
home, standing up the tunnel, hardening it, the whole operation - ran against an
AI coding agent. The bill is not a story about tokens in the abstract; it's a
real number.

That session: **$1.02**. Let me put a little more detail on it:

- Model used: a fast, cheap frontier-tier model over a router (OpenRouter).
- 260 agent steps - meaning 260 actual tool calls and actions, not 260 prompts.
- About 5.6 million tokens read in, 105k written, 58k spent on reasoning.
- Roughly 89% of the input was served from cache, which is why it stayed cheap.

A tax that high on a project this size, for context, would have been a rounding
error on the old cloud bill. The whole month of renting that server cost more
than this entire setup effort. And now the site runs on hardware I already own.
The ongoing cost is basically zero. It's the best value-per-step I've ever
gotten out of any engineer, human or otherwise.

![The whole setup cost about a dollar](/images/selfhost-coin.jpg)

## The part that surprised me

Not the cost - I expected that to be low. It was how *loaded the decisions were*.

The agent didn't just type commands. It asked me to choose, in plain language,
whether we used one managed tunnel provider or self-hosted our own edge, whether
we kept all DNS with our existing registrar, whether the whole thing should be
scriptable for the *next* site rather than just this one. It surfaced the 
trade-offs instead of silently picking for me.

By the end, the tunnel setup was reusable. Add a site = run one command. That's
the thing I'm most proud of, not the site being up - it's that the next one is
now cheap to add.

## The hardware, in general terms

I'll keep this vague on purpose. What matters isn't the exact chip, it's the
idea: a small, low-power box tucked next to the network gear, quieter and pulling
basically nothing, running a full cluster. Plenty of room to grow. If a box dies,
it's a Sunday-afternoon rebuild, not a data-center incident, because every byte
of how it's put together lives in git.

## The takeaway

You don't need to open a firewall to serve a website from home anymore. You don't
need to trust a port forward or pray about your ISP. A box that calls home solves
a problem that used to require a public IP.

And you don't need a big budget or a big team to set it up. Sometimes, for a
dollar and a handful of careful decisions, you get a real thing - and the next
one gets easier.