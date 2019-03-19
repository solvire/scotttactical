---
title: "Car Computer Hardware"
author: SScott
date: 2019-03-05T21:32:16-08:00
draft: false
url: car-computer-hardware
image: /images/trunk_computer.jpg
tags: ["car computer"]
comments: true
---

## Searching For The Right Car Computer Hardware

My trip to Fry's in LA this morning wasn't as great as I hoped. But I did get some great ideas on how to accomplish things.

There were two major themes in the hardware that I looked at.  

+ Small isolated modular things
+ Apple stuff

There wasn't much for integration or components that were universal. Either they were for their own little world or they were for some subset of the Apple ecosystem.  

## Arduino

![Arduino](/images/arduino.jpg)


Because the shelves were mostly barren I decided to spend more time looking at the prototyping things on Arduino. They actually gave me a lot of ideas. At least I could see the base components around it. Some of the things that I realized I was going to probably need.

* IR sensor for motion
* Battery hookup
* Embeddable camera
* Jumper cables
* Ethernet bridge
* Relay port (maybe 4 for other things?)

## The Processing PC

I determined that I wasn't going to be able to come up with a raspberry pi model that I would feel confident would run the software without causing pain.

### Shopping for Fanless Low Power PC

Fry's didn't have anything.  In fact it looked like they were going out of business.  We need more hackers. That's for another topic tho.

Here is the one that I went with:

<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=tf_til&ad_type=product_link&tracking_id=scotttactical-20&marketplace=amazon&region=US&placement=B07LC79DZ6&asins=B07LC79DZ6&linkId=127920f062688cef612e1c46944b3dd3&show_border=true&link_opens_in_new_window=true&price_color=333333&title_color=0066c0&bg_color=ffffff">
    </iframe>

Yes - shameless affiliate links.

Anyway here are the specs:

* Processor 	1.92 GHz Intel Atom
* RAM 	4 GB LPDDR3
* Hard Drive 	64 GB
* Graphics Coprocessor 	Intel HD Graphics
* Card Description 	integrated
* Number of USB 2.0 Ports 	2
* Brand Name 	Plater
* Series 	Z83-F [4GB+64GB]
* Item model number 	Z83-F [4GB+64GB]
* Hardware Platform 	PC
* Operating System 	Windows 10 Professional
* Item Weight 	1.34 pounds
* Product Dimensions 	4.7 x 4.7 x 1.1 inches
* Item Dimensions L x W x H 	4.72 x 4.72 x 1.06 inches
* Processor Brand 	Intel
* Processor Count 	4
* Computer Memory Type 	DDR3 SDRAM
* Hard Drive Interface 	USB 3.0
* Power Source 	DC12V 2A (100-240V, 50/60Hz)

One of the reasons that I wanted to go with this product is I saw someone installing ubuntu on it with a recent video:

 <iframe width="560" height="315" src="https://www.youtube.com/embed/2djTPJ02xK0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

 It always helps to see other people doing these things ahead of me. Bravo to you.


## Inverters

I neglected to spend the time researching this and got the wrong inverter. Make sure you understand what inverter types there are.

There is a pure and modified sine wave inversion when going from DC to AC.

https://invertersrus.com/pure-sine-vs-modified-sine/

> All power inverters convert DC power (which is power stored in batteries) to AC power, which is the power supplied by the electric company and fed to your home. Electronic devices need AC power to operate, but power inverters generally output power in two forms, modified sine wave vs. pure sine wave.



{{% img src="images/modified-sine-wave-vs-pure-sine-wave.jpg" caption="Modified sine wave vs pure sine wave" href="https://www.altestore.com/blog/2015/10/pure-sine-wave-vs-modified-sine-wave-whats-the-difference/#.XIhgDtFlC-w"  %}}

Modified Sine Waves

* square broken steps that oscillate

Pure Sine Waves

* smooth rolling waves


{{% img src="images/modified-sine-wave-and-pure-sine-wave-oscilloscope.jpg" caption="Modified sine wave vs pure sine wave" href="https://www.altestore.com/blog/2015/10/pure-sine-wave-vs-modified-sine-wave-whats-the-difference/#.XIhgDtFlC-w"  %}}


Initially I picked up this:

<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ss&ref=as_ss_li_til&ad_type=product_link&tracking_id=scotttactical-20&language=en_US&marketplace=amazon&region=US&placement=B004MDXS0U&asins=B004MDXS0U&linkId=e5896cb136c14edd839abc2de085eb57&show_border=true&link_opens_in_new_window=true"></iframe>

I thought it was a nice inverter at a good price. But not for what I need to do.
