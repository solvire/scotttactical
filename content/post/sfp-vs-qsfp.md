---
date: 2017-01-04T06:41:07-08:00
draft: false
title: "SFP vs. QSFP"
comments: true
tags: [ data, networking ]
---

## Networking Transceivers

This is all pretty new stuff for me. I have been a cat5 ethernet guy since the beginning. There was just never a need to push more data than what I was getting. But now with converged storage that need is quite apparent.  After having deployed a MapR-FS and doing a speed test I realized where I needed to make improvements.

Again this page is mostly for my notes.

## SFP and SFP+

SFP stands for "small form-factor pluggable". It is a hot-pluggable transceiver. It allows for connecting devices via a fiber optic cable or copper cable. I have mostly seen fiber optics in data centers but didn't really know what they were about.

See [Small Form Factor Committee](https://en.wikipedia.org/wiki/Small_Form_Factor_Committee) for more information.  

### Data Rates by Type


[SFP](https://en.wikipedia.org/wiki/Small_form-factor_pluggable_transceiver) is rated for 1Gb, 2.5Gb and 10Gb/s traffic.

There different distance ratings of the cabling based on specifications outside my expertise.

SFP+ takes the data rate up to 10Gb/sec and is supposed to move 16Gb/sec but at that point you are probably limited by your hardware.

SFP28 enhances the transceiver again by moving toward the 100Gb rates by allowing for multiple 25G channels. This is an advantage because the channels of 1/10/40/100 require more power and cooling compared to the 1/25/50/100 channels of the proposed gear. Again, it is above my skill level.


### CSFP

CSFP stands for compact small form-factor pluggable (CSFP). I haven't used this but it seems to be designed for higher density and bi-directional traffic.

## QSFP and QSFP+

Here is where things get a little more interesting. I didn't realize before that to get more bandwidth they were basically stacking technologies.

![Wiki](https://upload.wikimedia.org/wikipedia/commons/0/0e/QSFP-40G-SR4_Transceiver.jpg)

[QSFP](https://en.wikipedia.org/wiki/QSFP) stands for Quad Small Form-factor Pluggable. It is just as you suspect. 4 X SFP. 4 channels of SFP traffic.

So the math is fairly easy. If you have 4 times the 10G traffic of an SFP+ then you have 40G potential. Pretty cool.

Here are some examples:

- 4 x 4 Gbit/s QSFP
- 4 x 10 Gbit/s QSFP+
  - 10GbE, FC, Infiniband
  - Combined to 40Gb
- 4 x 14 Gbit/s QSFP+ (QSFP14)
  - FDR Infiniband and SAS-3
- 4 x 28 Gbit/s QSFP+ (QSFP28)
  - 100GbE
  - Infiniband

## Fanout or Breakout Cables

I thought this was really cool. Similar to SAS controllers you can split the connections of the channels out. Essentially you use one port to power 4 10G nics. This is great if you have a switch with many high density ports.

![Breakout](https://upload.wikimedia.org/wikipedia/commons/e/e6/Optical_breakout_cable.jpg)

![sfpopticaltransceiver.com](http://www.sfpopticaltransceiver.com/photo/pc1313968-extreme_qsfp_copper_cable_qsfp_to_sfp_fan_out_cable_for_network.jpg)

## Conclusion

I will write my notes down regarding the technologies that employ these connectors. That is even more interesting. Basically this type of networking puts supercomputing into the hands of mere mortals.

Please feel free to correct me if I am wrong in the comments below. I am open to suggestion.
