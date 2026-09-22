---
date: 2026-09-21T20:00:00-07:00
draft: false
title: "How an AI Coding Agent Rebuilt This Site"
url: /site-modernization-2026-09/
categories:
  - Software
tags: [ hugo, llm, ai, meta, engineering ]
comments: false
---

## The bottom line

This site was rebuilt by an AI coding agent, and this page is the part of that
job most people do not see. Below is not just what happened. It is also the
boring, nerdy underneath: what the model is, how the work is measured, what
tokens, wall time, and effort actually mean, and why a human would even bother.

That is the part an SEO crawler will eat up, and the part a curious engineer
will actually enjoy.

## Who (or what) did the work

The agent is the Kilo CLI, and the model behind it for this session was
`deepseek/deepseek-v4-flash` (serve-spec id
`openrouter/deepseek/deepseek-v4-flash-0731`). That is a long way of saying:
a large language model running a code agent harness, given a terminal, a filesystem,
and a set of rules.

A code agent is not ChatGPT in a box. It is a loop. It reads a file, decides,
runs a command, reads the output, decides again. For this job it shelled into a
Docker container running Hugo, built the site, served it, curl'd its own pages,
diffed URL trees, and compared old versus new output -- all without a human
retyping a single command.

## The actual job

The scotttactical.com source was 2016-era: old capital-case Hugo config, a
vendored Bootstrap 3 theme, and a gulp-3 LESS pipeline that no longer even built
on modern Node. The production site was serving a stale, prebuilt `public/`.

The modernization, end to end:

1. Probed the repo and dumped every config, layout, partial, and piece of front
   matter to understand the URL map before touching anything.
2. Proved the theme could be salvaged by running modern Hugo against it and
   capturing the concrete errors (three removed APIs: `getJSON`, and the
   `_internal/google_analytics.html` and `_internal/disqus.html` templates).
3. Wrote a single modern `hugo.toml`.
4. Surgically patched the theme: inlined Google Analytics and Disqus, rewrote
   the gallery schema to stop calling the dead remote host.
5. Retired gulp/less and folded the CSS into the theme's static assets.
6. Made the Dockerfile a real multi-stage build.
7. Built it, served it, crawled it: zero broken internal links, and every
   source-authored URL preserved.

That last part mattered most. The old `public/` was not even one coherent build,
it interleaved three Hugo generations with 11 pages pointing at localhost and 38
referencing dead CDN assets. The requirement was not "match those bytes." It was:
never change a URL that links and SEO depend on.

## Tokens, wall time, and effort -- translated

These are the three numbers people actually mean when they talk about AI work,
and they are not the same thing.

**Tokens.** A token is roughly 3/4 of a word to the model. Everything the agent
reads and writes -- every file, every command output, every diff -- is a stream
of tokens flowing through a context window. This site is a handful of megabytes
of source; the working set that matters is what fits in the context window at
once. A good agent reads a file, uses it, and lets it age out, rather than
loading the world and losing track of the task.

**Wall time.** This is clock time, real seconds. Context windows are big but the
model still moves at a rate, and every tool call -- a Docker build, a curl, a
git diff -- has latency. Objects and code render faster than reasoning; heavy
steps are the build and the crawl, not the typing.

**Effort.** The highest-leverage quantity. A code agent chooses how deliberately
it reasons before it acts. For grunt work it can go shallow and fast. For a task
like "do not change the URL map," it must go deep: trace every post's front
matter, diff every generated path, prove the new tree is a superset of the
intended old one. The same model can burn tokens fast on nothing, or spend them
slowly and land exactly on the target. Effort is where the discipline lives.

## Why do it this way at all

Three reasons.

**Reproducibility.** The whole pipeline compiles in Docker from source now. A
new machine, a fresh clone, a container build -- same site. No hidden state, no
"it built on my laptop." That is worth more than the cost of the compute.

**The URL map is the contract.** A static site's resale value is its links. The
readiness to rewrite without relocating -- to move the build and leave every URL
standing -- is the entire point of doing this with a tool that can diff instead
of eyeball.

**Because keeping a hand-built template alive is expensive.** gulp-3 LESS was
dead weight. The humans here did not want a redesign-drift treadmill; they wanted
the build stack modern enough that the next change is one file, not a war.

## The actual bill

Because it is fun and honest to show your work, here are the real figures the
platform reported for the session that did this.

| Quantity | Value | What it means |
|---|---|---|
| Provider / route | OpenRouter - DeepSeek V4 Flash 0731 | the actual generation model behind the agent |
| Steps | 240 | tool calls + model turns across the whole job |
| Cost | $0.738502 | total spend, sub-one-dollar |
| Input tokens | 2,253,923 | everything read: files, configs, command output, diffs |
| Output tokens | 73,567 | everything generated: edits, explanations, commands |
| Reasoning tokens | 64,246 | the intermediate chain-of-thought, not shown to you |
| Cache read | 35,009,024 | cached-context tokens served without recompute |
| Cache write | 0 | nothing fresh persisted to cache this run |
| Cache hit rate | 94.0% | how much of the context was reused, not recomputed |
| Wall time | roughly 3 hours of human chat + seconds of actual compute | the model work itself was seconds across 240 steps |

Read those numbers the way an engineer would.

**Input over output, ~30x.** The agent consumed about 30 tokens of context for
every token it wrote. That is not waste; it is the whole point of a code agent.
To move a site without breaking its URL map, the model has to *look* -- at the
config, at every post's front matter, at the old build, at the diff -- far more
than it writes. A setting that reads barely anything is a setting guessing.

**Caching did the work.** 35M cached tokens against 2.2M fresh input, a 94% hit
rate, and a $0.74 bill. The reason it was cheap is not that the model is weak; it
is that most of the context (the repo, the rules, the earlier turns) was already
in cache and never recomputed. Cache is the reason context windows got usable at
all. That 94% is the load-bearing number in the whole table.

**Reasoning is billed separately and hidden.** 64K tokens went to internal
reasoning you never saw -- the "should I trust this theory about the URL before
I edit it" thinking. It is not shown to you because you asked for the result, not
the deliberation. But it is real, it is counted, and it is why effort is a knob
you pay for by the ounce rather than by the line.

**$0.74 to rebuild a 2016 site.** The model itself cost less than a coffee.
Every worthwhile cost in this task was human attention -- deciding the URL map
must not move, deciding the dependencies are a controlled one, deciding when to
stop. The compute was the cheap part.

## You can draw in posts now

This theme gained a mermaid shortcode while this build was in progress. There
was no mermaid support in Hugo out of the box -- Hugo renders Markdown, and a
fenced code block is just a code block until something runs the diagram
javascript. We added a tiny `mermaid` shortcode (a `<pre class="mermaid">`
wrapper) and loaded the mermaid.js script in the base layout. Now any post can
drop in a real flow diagram, no external image host needed. Like the loop that
did this job:

{{< mermaid >}}
flowchart TD
  A[Read repo + URL map] --> B{Build with modern Hugo}
  B -- fails --> C[Capture the concrete error]
  C --> A
  B -- ok --> D[Verify URLs and assets unchanged]
  D --> F[OK]
{{< /mermaid >}}

The text is the diagram. That is the whole trick of a chart you can keep in
git.

## The honest asterisk

The model cannot run the step counter or the billing meter; the platform does.
Those numbers above came from the operator's OpenRouter dashboard, not from the
model, and they arrived after the session. So treat them as the ground truth of
what this job cost -- and treat the model's own claims about itself with the same
caution you would any narrator.

What is true regardless of the meter: the working set fit in context, the build
was verified against itself, the production artifact was never deleted or
committed without approval, and the model's purpose is to spend your effort
budget where it counts, keep the diff small, and be honest about the parts it
cannot prove.