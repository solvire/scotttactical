---
date: 2026-10-12T22:00:00-07:00
draft: true
title: "Designing a Car Computer: The Plan Before the Parts"
url: /designing-a-car-computer/
# thumbnail: images/car_computer/talking-cars-collage.jpg   # hero/card/social - the theme reads 'thumbnail', not 'image'. ADD LATER.
categories:
  - Hardware
tags: [ car-computer, raspberry-pi, esp32, architecture, offline, design, engineering, build-log ]
comments: false
---

<!-- HERO / FIGURE (collage): the famous talking/smart vehicles with personalities.
     File: static/images/car_computer/talking-cars-collage.jpg
     Cast: KITT (Knight Rider); Jarvis (Iron Man); Christine (Stephen King -- the
     antithesis); the General Lee, "Dixie" (Dukes of Hazzard -- our namesake);
     Lightning McQueen (Cars -- the fun one). Editorial montage; all are
     copyrighted properties, so treat as commentary. -->
<!-- {{% img src="images/car_computer/talking-cars-collage.jpg" caption="KITT, Jarvis, Christine, Dixie, and McQueen -- the personality pantry for this build." %}} -->

You know you want to own your own KITT. Every little boy who grew up in the '80s
thought about it. I did. I never thought it was possible. With all the AI tools we
have now, it is more realistic -- and, in the same breath, a little less
interesting. But I still wanted to get it dialed in.

It needed to do more than just talk. And then there is the overall constraint:
**power. It is always about power.** Edge AI is not quite ready outside of very
narrow tasks, and then there is security and the easy vectors for hacking.

Siri and Alexa are okay. I do not particularly like them. They do a poor job of
what I want, and they have **zero personality** -- by design. This one is meant to
have *some* personality. I love my cars. To me they all have a spirit, some sort
of personality; each one has meant something to me. My Jeep CJ5 was absolutely
possessed by demons, and to this day it is my favorite vehicle. I will forever
miss that truck.

But let us dig into giving this thing some life.

We need to walk up, wake the truck, and go. It has to boot fast, get going, and
then communicate once the main brain is awake. It is a simple loop that will
absolutely spider into a mess. It has to be smart. And a lot of it will be custom
hardware, because the world of sensors assumes a constant power source.

Let us go.

For the record, the patient is a 1969 Chevy Blazer -- old, loud, all steel -- plus
a second truck, a Dodge. The north-star moment is the one above: I walk up, say
*"Hey Dixie,"* the truck wakes, and it answers. Everything below falls out of that:
**how early can we detect presence, confirm it is me, and boot the machine?** The
approach *is* the product.

What follows is the plan -- three versions of it -- and the arguments that moved
it. The parts and the sourcing traps are a separate post; this one is the design
before the parts. Which is funnier than it sounds, because I got it wrong twice.

## Iteration 1: presence boots the Pi, the wake word does not

The first real insight came from reframing the question. The critical path is not
the wake word. It is the **boot**: a cold Raspberry Pi takes roughly fifteen
seconds to come up. Spending the wake word on *booting* the computer is a waste,
because the wake word is the slow, expensive part and booting is unavoidable.

So the design flipped: **presence boots the Pi, the wake word runs on the Pi after
boot as the engage/auth moment.** Presence is phone Bluetooth (BLE) plus motion.
Those two are a redundant trigger -- there is no realistic approach where both
fail -- which is why no always-on low-power microphone is needed just to wake the
thing.

{{< mermaid >}}
flowchart LR
    B[Phone BLE in range] --> E[ESP32 sentry]
    M[Motion / PIR] --> E
    E -->|credible presence| BOOT[Wake Pi - boot ~15s]
    BOOT --> READY[Pi ready, models preloaded]
    S[Hey Dixie - on the Pi, post-boot] --> ID[Voice + phone identity]
    READY --> ID
    ID -->|match| UNLOCK[Unlock + authorize]
    ID -->|no match| SLEEP[back to sleep]
{{< /mermaid >}}

A few false wake-ups are acceptable here. The truck runs the computer off an
isolated auxiliary battery, and the starter battery is protected by an isolator, so
a spurious boot is a rounding error, not a dead truck in the morning.

## The bench told me the Pi was the wrong layer

Then I actually built the offline voice pipeline and measured it, and the plan
took a hit.

- Speech to text (sherpa-onnx streaming model) worked: real-time factor 0.234,
  faster than real time on the Pi.
- Text to speech (Piper) worked.
- The wake word was the problem. `openWakeWord`'s bundled models returned roughly
  **zero confidence** on this Pi's software stack -- confirmed a bad fit, dropped.
  A custom *"Hey Dixie"* keyword via sherpa's keyword spotter detected synthesized
  speech but **did not fire on a real human voice.** That is fatal for a wake word.
- And the model load was **~8 to 16 seconds** -- a number that sits right in the
  path of someone standing at the door.

## Where I was wrong

Here is the part I have to own. When the operator kept pointing at an always-on
microcontroller front-end to own the wake word, I argued against it on **power**
grounds -- "no benefit once the Pi is up." I was solving the wrong problem.

The operator's point was **engage latency**, not power. Sixteen seconds of model
load in front of a person at the door is unacceptable no matter how efficient it
is. An always-on ESP32-class chip detects the wake word instantly and boots the Pi
in the background behind the approach. Once I measured the latency, the earlier
"no benefit" claim collapsed. The edge wake word is load-bearing, justified by
latency.

That is the lesson I keep relearning on this project: the instinct to add an
always-on low-power layer was right, and I dismissed it because I was scoring the
decision on the wrong axis.

## Iteration 2: the operator said no

After the live testing, the operator rejected the voice design outright -- *not
satisfactory* -- and asked for a rethink with speed and a car-realistic power
model. That killed the idea of the sentry listening for a wake word at all.

The revised design dropped the wake word from the sentry entirely. The sentry
became a **duty-cycled BLE presence scanner plus an ignition sense** -- nothing
more. PIR and the wake-word microphone came off the always-on chip. Presence boots
the Pi; the wake word waits on the Pi and fires in well under a second once loaded.

The power side got the same treatment. The Pi cannot hibernate, so it has to be
**off** when idle, and that wanted a purpose-built power-management HAT instead of
a taped-down buck and bulky relays. The HAT takes the vehicle's 12 V directly,
soft-latches the Pi on, shuts it down gracefully, and holds a real-time clock. And
**ignition is the power authority**: the Pi runs for a few minutes after the key
goes off, then shuts down; an explicit "power off" cuts it immediately.

## Identity is two different things

One of the cleanest decisions to fall out of the rethink: **voice and the phone do
different jobs.**

- **Voice is identification** -- a low barrier, for greeting and engagement.
- **The phone is authentication** -- it is what unlocks.

Voice alone is never allowed to unlock. A recorded playback of the owner's voice
should not open the truck. Unlock is gated on the phone being present, and the
phone is identified by a **beacon/app token, not a raw MAC address**, because
phones rotate their MAC addresses. No phone, or an unrecognized phone, means no
wake, or a wake that stays locked. "Can't just unlock for anyone who walks up" is
the hard requirement, and it points at the phone, not the microphone.

## Three tiers, each standing alone

The power model finally settled into three engagement tiers, and the rule that
keeps it honest is that **a lower tier must work with no higher tier present.**

{{< mermaid >}}
flowchart TB
    L1[Tier 1 Sentry - Pi OFF<br/>ESP32 BLE presence + ignition sense]
    L2[Tier 2 Armed - Pi ON, offline<br/>local voice, Hey Dixie, identity greeting]
    L3[Tier 3 Alive - Pi + phone uplink<br/>network, CarPlay, richer conversation]
    L1 --> L2 --> L3
{{< /mermaid >}}

Tier 2 is deliberately lean and fully offline. Tier 3 -- using the network -- is a
detected escalation that needs the phone to actually provide an uplink; it is never
a dependency. If the phone has no signal, the truck still works.

## The stack that finally fit

The wake word moved to **Picovoice Porcupine** with a custom *"Hey Dixie"*. It
loads in well under a second and works on real voices -- exactly the two things the
sherpa keyword failed at. Intent parsing moved to **Rhino** (intent plus slots),
which replaces both the heavy speech-to-text model and a hand-rolled regex matcher
for the fixed command set. Text to speech stays **Piper** (open source). Picovoice
is proprietary but free for personal use, and the operator accepted that trade; the
sherpa pipeline stays as a fallback.

The other half of the latency fix was unglamorous: **preload the models at boot as
a system service**, so no model-load time ever lands in the interaction path. The
16-second load did not disappear -- it moved to where nobody is waiting on it.

## Power and the sentry: the handshake

Because neither the sentry nor the Pi should ever be a single point of failure,
power-on and power-off are a two-way handshake:

{{< mermaid >}}
sequenceDiagram
    participant Phone
    participant ESP32 as ESP32 sentry
    participant Witty as Witty Pi HAT
    participant Pi as Raspberry Pi
    Phone->>ESP32: BLE presence (beacon token)
    ESP32->>ESP32: check ignition sense
    ESP32->>Witty: momentary power-on pulse
    Witty->>Pi: latch 12V, boot (~15s)
    Pi->>Pi: preload voice models
    Pi->>ESP32: heartbeat
    Note over ESP32,Pi: heartbeat stops - ESP32 force-cuts power
{{< /mermaid >}}

The ESP32 pulses the HAT to start the Pi; the Pi then self-latches its own power so
it does not depend on the ESP32 staying alive; and the Pi emits a heartbeat the
ESP32 watches, so if the Pi hangs, the always-on chip force-cuts power rather than
letting a wedged computer drain the battery. The fail-safe default is
**de-energized: the Pi is off.**

## The physical design caught up last

Hardware reality forced a few more design calls once the electrical design was
settled:

- **Audio, parked:** the amp and subwoofer are ignition-gated, so a parked,
  key-off Pi has no audio path at all. Rather than power a speaker to say
  something, the always-on ESP32 drives a **large piezo through a small driver
  amp** for a car-alarm chirp (one chirp heard, two unlocked, three denied). It is
  piercing and draws almost nothing. Full spoken responses only play with the
  ignition on, through the existing Kenwood.
- **Cooling:** deferred. Run the Pi and watch the throttle flags; add a heatsink
  only if it actually throttles. That decision removed an entire clearance problem
  under the HAT.
- **Housing is a first-class item**, not an afterthought. Design to the measured
  stack, not a guess. Two constraints came out of it: the HAT covers the display's
  power jumper on the 40-pin header (so the screen's 5 V has to be re-routed), and
  the sentry enclosure needs an **RF path out of the all-steel body** -- a board
  antenna inside a steel dash is close to useless -- plus the piezo where its chirp
  can actually escape the cabin.

<!-- PLACEHOLDER (figure): the assembled Pi 4 + Witty Pi HAT stack, side-on, on
     the bench. File: static/images/car_computer/design-stack.jpg
     Capture once the HAT is mounted. -->

## Where it stands

The design is frozen at version three: ESP32-S3 sentry, a power HAT, ignition as
the authority, and an offline Picovoice voice stack on the Pi. The parts are
sourced and ordered (that is the other post). Both Raspberry Pi units are imaged
and stress-tested -- passed. Next is bench bring-up: the HAT's soft-latch and
graceful shutdown, BLE range through the steel, and the voice stack on the Pi.

## What I would tell myself

- **Power first, then latency.** The load-bearing constraints were "keep it off"
  and "start it fast," not "which model."
- **Do not score an architecture decision on the wrong axis.** I rejected the
  always-on front-end on power when the real question was engage latency.
- **Presence and the wake word are different jobs.** Presence boots; the wake word
  engages. Mixing them is what makes the design slow.
- **Split identity.** Voice greets; the phone authorizes. Never let a microphone
  be the lock.
- **Measure, do not guess.** Almost every reversal here came from a measurement --
  a load time, a real-voice failure, a confidence score near zero.
