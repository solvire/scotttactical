---
date: 2026-10-12T21:00:00-07:00
draft: true
title: "Designing a Car Computer: Sourcing the Hardware"
url: /sourcing-a-car-computer/
# image: images/car_computer/sourcing-flatlay.jpg   # hero/social - ADD LATER (needs all parts in hand)
categories:
  - Hardware
tags: [ car-computer, raspberry-pi, esp32, adafruit, sourcing, hardware, engineering, build-log ]
comments: false
---

<!-- PLACEHOLDER (hero): bench flat-lay of every part as it arrived.
     File: static/images/car_computer/sourcing-flatlay.jpg
     Used as both the front-matter hero and a body figure. Capture once all parts are in. -->

The whole build starts with one stubborn constraint: the truck sits for days at a
time, and when it sits, nothing is supposed to be awake. This is a computer for a
1969 Chevy Blazer (and a second truck, a Dodge). It sleeps until my phone comes
near, wakes, boots, and talks. Offline-first, low power, always-on *sentry* that
draws almost nothing and a real computer that stays dark until it is needed.

I am not going to walk through the software here. This post is about the part of
the project nobody writes up: **sourcing the hardware.** How each part got
researched, why one variant beat another, where it came from, and the traps that
ate an afternoon. If you are planning anything similar, the traps are the useful
part.

<!-- PLACEHOLDER (figure): the sourcing haul laid out. Same shot as the hero, or a
     tighter second angle. -->

## The vendor map

Almost every choice came down to "who actually has the real part, in stock, and
will say what it is." That sorted the build into four lanes:

- **Adafruit (US)** for the Raspberry Pi, the power HAT, the microcontroller, and
  the small breakouts. They stock genuine parts, publish real datasheets, and the
  product pages warn you about the gotchas.
- **Data Alliance (US)** for RF connectors and antennas. This turned out to be the
  most important sourcing decision of the whole build (see the connector trap
  below).
- **Amazon** for commodity: the DC-DC buck, tools, soldering supplies, SD cards.
- **Local / automotive** for the fuse, 12 V wire, the ignition-sense optocoupler,
  and the harness. Bin stock, bought by the unit, no shipping.

The rule I keep relearning: the fancy parts come from the specialist, and the
boring parts come from wherever is closest. Trying to save two dollars on a
connector by buying the wrong thing from Amazon cost more than the right part ever
would have.

## The power HAT, and a variant trap

The heart of the sleep/wake design is a power-management HAT on the Pi. I wanted
the UUGear Witty Pi line: it takes 12 V straight from the vehicle, soft-switches
the Pi, and shuts it down gracefully. Adafruit sells it in the US.

Two traps here.

First, the **Witty Pi 4 is out of stock.** That is the model the architecture doc
originally named, and it simply was not available when I went to buy.

Second, and sneakier: there is a **Witty Pi 4 "L3V7" variant**, and it is *not*
the same part. L3V7 is the 3.7 V Li-ion version. It takes **5 V in over USB-C** --
it is a battery UPS, not a wide-input vehicle supply. If I had grabbed it because
the model number looked close, I would have bought a 5 V board for a 12 V truck.

The in-stock pick was the **Witty Pi 5 HAT+**: 6-30 V input (takes the vehicle 12 V
directly, no separate buck in the Pi path), up to 5 A out, and it supports both the
Pi 4 and the Pi 5. It is the vehicle variant the build actually needed.

<!-- PLACEHOLDER (figure): Witty Pi 5 HAT+ next to the L3V7 variant (or their boxes),
     to show the trap concretely. File: static/images/car_computer/witty-variant.jpg -->

## The Pi 4 price shock

A note for anyone building in 2026: **the Raspberry Pi 4 is not a $55 board
anymore.** The 4 GB model was about **$120** at Adafruit when I ordered, and the
8 GB was around **$190**. DRAM pricing is the driver, and it is volatile -- verify
at the moment you order, because the number you read in a forum post from six
months ago is fiction now.

I still bought the Pi 4, deliberately, over the Pi 5: it uses less power, and it
keeps the 3.5 mm analog audio jack that the voice output path depends on.

## The sentry brain

The always-on half of the system is a small microcontroller doing a duty-cycled
BLE scan for my phone, watching ignition, and chirping. I picked the **Adafruit
ESP32-S3 Feather 8 MB with w.FL** (product 5885): native USB-C, plenty of flash,
and a connector for an external antenna -- which matters because the entire truck
body is steel and a PCB antenna inside a steel console is close to useless.

One small gotcha: **the pin headers ship loose.** You solder them on yourself.
Fine with a Pinecil, but it is a "read the box" moment, not a "plug it in" moment.

## The connector trap (the centerpiece)

If you take one thing from this post, take this.

The Feather's tiny RF port is **w.FL**. That is the same thing as **I-PEX MHF3**.
It is **not** u.FL. It is **not** MHF4. They look almost identical at a glance and
they do not mate.

{{< mermaid >}}
flowchart TD
    Port[Tiny RF port on the board] --> Q{Which series is it?}
    Q -->|w.FL| A[w.FL = I-PEX MHF3<br/>CORRECT: W.FL-to-RP-SMA]
    Q -->|u.FL| B[u.FL<br/>WRONG - does not mate]
    Q -->|MHF4 / IPEX4| C[MHF4<br/>WRONG - cheap and everywhere,<br/>but does not mate]
    A --> D[RP-SMA bulkhead + 2.4 GHz antenna]
{{< /mermaid >}}

Here is how the trap works. The Adafruit pinout page had stale text calling the
port "u.FL," which sent me looking for u.FL cables. Amazon listings are worse:
plenty of them are labeled "u.FL" while showing something that looks like w.FL,
and the cheap **"MHF4 / IPEX4"** antennas and pigtails -- which are everywhere and
cheap -- **do not mate with this board at all.** You buy the wrong one, it arrives,
and it physically will not connect. No adapter saves you; the series is wrong.

<!-- PLACEHOLDER (figure, money shot): macro of w.FL (MHF3) vs u.FL vs MHF4 side by
     side, with a coin or ruler for scale. File: static/images/car_computer/connector-macro.jpg -->

The fix came from going to a specialist instead of a marketplace. **Data Alliance**
states it plainly, in the product copy, in the open:

> "W.FL (HiRose) is equivalent to MHF3 (I-PEX)."

That one sentence is the whole resolution. The correct cable is a
**W.FL-to-RP-SMA**. Not u.FL. Not MHF4. W.FL.

One more caveat that shaped the whole antenna plan: **w.FL is rated for only about
20 mating cycles.** This is a connect-once connector. I am not going to be
plugging and unplugging this while I debug; I build the cable into the design and
leave it alone.

## The antenna assembly

The RF chain had to get the signal out through a steel case wall, so:

- A **W.FL-to-RP-SMA-female cable from Data Alliance** whose RP-SMA end is a
  **bulkhead** -- it mounts *through* the case wall with a nut and washer, and the
  antenna screws on outside.
- A **2.4 GHz RP-SMA antenna** on that bulkhead.
- A **flat O-ring** for the bulkhead (with the brass nut/washer it seals to IP68).

Two sourcing notes that matter. The cable is deliberately **short** -- the thin
0.81 mm coax loses signal at 2.4 GHz, so every extra inch is range you throw away.
And the bulkhead thread is 3/8 in, so the case wall has to stay thin (about
9.5 mm); buy the longer-thread version if your wall is thicker.

## The DC-DC buck

The sentry needs its own 12 V-to-5 V converter. I went cheap and waterproof: a
**PlusRoc 12/24 V -> 5 V 5 A waterproof buck, sold as a 2-pack on Amazon**, over a
pricier Pololu module. The deciding feature was the **USB-C output** -- it plugs
straight into the Feather's USB-C port, no terminal-block wiring in a cramped box.
It is its own converter, deliberately: the other buck in the project is soldered to
the dev Pi and is not free to steal.

## The chirp

Parked feedback is a **chirp**, not speech -- the amp and sub are ignition-gated, so
a parked Pi has no audio path. That comes from a **PAM8904 piezo driver amp** and a
**large enclosed piezo**, wired to the Feather with a **STEMMA JST-PH cable**. A
bare piezo off a 3.3 V GPIO is weak; the driver makes it a real car-alarm chirp.

Small connector note: the Feather's JST is STEMMA QT (JST-SH, I2C), which is a
*different* connector from the 3-pin JST-PH the PAM8904 wants. Get the right cable.

## What I considered and rejected

**PiSugar 3 / 3 Plus**, the bottom-mount pogo-pin UPS. It is genuinely clever -- no
GPIO header, no heatsink conflict, on-board RTC, graceful shutdown. Two reasons it
lost: it is **5 V/3 A in and out only** (a 12 V buck would still be required, where
the Witty Pi takes 12 V direct), and it puts a **Li-ion cell inside a hot cabin.**
The vehicle already has an auxiliary battery; that *is* the UPS. Adding a second
battery in a truck that bakes in the sun is a safety problem looking for a place to
happen. Rejected.

## Takeaways

- **US vs overseas sourcing is a real design input.** Specialists for parts where
  correctness matters; commodity from whoever is fast and cheap.
- **Out-of-stock and variant traps are the norm.** The model number being close is
  exactly how you buy the wrong board.
- **Connector naming is chaos.** w.FL = MHF3, and no amount of squinting makes it
  true that it equals u.FL or MHF4. Trust the specialist's plain-language copy.
- **Prices are volatile.** Verify at order time, and expect the Pi to have moved.
- **Buy spares.** I ordered three of the RF parts for two trucks; the parts are
  tiny, cheap, and a wrong or broken one otherwise stops the build for a week.
- **Measure, do not guess.** Every electrical value in this project is a guess until
  it is measured on the bench.

## Where it stands

Everything is ordered or in hand. Both Pi 4 units are imaged and stress-tested
(passed). Next: bench-verify the power path and the sentry wiring before anything
goes live in the truck.

## Parts

Approximate prices, USD. Some are from a multi-item order; "see order log" means
the line item was not priced individually here.

| Item | Vendor | Approx price |
|---|---|---|
| Raspberry Pi 4 Model B, 4 GB | Adafruit | ~$120 each |
| UUGear Witty Pi 5 HAT+ (6-30 V, 5 A) | Adafruit | $59.95 |
| ESP32-S3 Feather 8 MB with w.FL (5885) | Adafruit | see order log |
| PAM8904 piezo driver amp (5791) | Adafruit | $4.95 |
| Large enclosed piezo (1739) | Adafruit | $0.95 |
| STEMMA JST-PH 3-pin socket cable (3894) | Adafruit | see order log |
| Miniature 5 V fan (3368) | Adafruit | $3.50 |
| CR2032 coin cell (654) | Adafruit | see order log |
| 5.1 V 3 A USB-C supply (4298) | Adafruit | see order log |
| W.FL (MHF3) to RP-SMA-female bulkhead cable, 3 in | Data Alliance | $3.90 |
| 2.4 GHz 5 dBi RP-SMA antenna (right-angle) | Data Alliance | $2.50 |
| Flat O-ring for SMA/RP-SMA | Data Alliance | $0.18 |
| PlusRoc waterproof 12/24 V -> 5 V 5 A USB-C buck (2-pack) | Amazon | $15.99 |
| Pinecil soldering iron | Amazon | $39.99 |
| 63/37 solder wire, 1.0 mm | Amazon | $7.39 |
| ARCTIC MX-7 thermal paste | Amazon | $8.59 |
| microSDXC 64 GB A2 U3 card (x2) | Amazon | $42.91 (2) |
| 1 A fuse, 12 V wire, optocoupler (PC817), harness | local / automotive | bin stock |
