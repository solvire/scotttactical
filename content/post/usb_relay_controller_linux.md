---
title: "Linux USB Relay Controller"
author: SScott
date: 2019-03-11T01:10:53-07:00
draft: false
url: linux-usb-relay-controller
image: /images/trunk_computer.jpg
tags: ["car computer"]
comments: true
---

## Finding A Relay Controller

One of my bigger worries is working with peripherals.  I needed to find a camera and I felt like that was going to be easy enough.  The relay controller will hit the actuators running the door locks.

## What Is A Relay Switch

Most things inside a car take a decent amount of power to actuate or power them. The car is limited to 12V DC and your other measurements are amps and watts.  Most wiring coming from a computer are rated for very very low current.  This is because those are only carrying signal. With the exception of your charging and some power over wire like USB and Ethernet.

I don't have data on what it takes to power the locks because their specs are limited. But I am not going to take the chance.

{{% img src="images/relay.gif" caption="What is a relay switch." href="https://www.explainthatstuff.com/howrelayswork.html" %}}

What a relay does is take a low power input and throw a bigger switch so greater power can pass through it.  Think of it as leverage against the current. That analogy doesn't really do it justice.

https://www.explainthatstuff.com/howrelayswork.html

Switches are used all over automotive applications.  In the blazer I have a few relays on the lights but later there will be a lot more running other things that are constant heavy draw.


## Criteria

Here are a few of the criteria needed

* constant off
* momentary on (actuate lock)
* momentary on (actuate off)
* 12V DC power source
* low closed state power draw (common component on the vehicle anyway)
* FTDI chipset(?)

## USB Drivers

It looks like there is a standard format for talking over USB to these controller broads.

There seem to be a few drivers for peripherals however.

### FTDI

FTDI: https://www.ftdichip.com/FTDrivers.htm

https://www.ftdichip.com/Drivers/D2XX/Linux/ReadMe-linux.txt

This theoretically should allow for me to connect a USB device and have it picked up right away. That is what I would like.

The goal is for this to plug in and run lsusb to see it.

  lsusb
  dmesg | tail


  see: sudo apt install moserial


### HIDAPI

> HIDAPI is a multi-platform library which allows an application to interface
with USB and Bluetooth HID-Class devices on Windows, Linux, FreeBSD, and Mac
OS X.

* Windows (using hid.dll)
* Linux/hidraw (using the Kernel's hidraw driver)
* Linux/libusb (using libusb-1.0)
* FreeBSD (using libusb-1.0)
* Mac (using IOHidManager)

Drivers:

https://github.com/signal11/hidapi

https://github.com/darrylb123/usbrelay



## Shopping For a USB Relay


Here are a few options that I ran into.

### Selection 1

I seemed to like this board best but it was coming from belgrade and wouldn't be here for weeks.


* 4 SPDT Relays RAS-05-15 (10A / 250VAC, 15A / 120VAC, 15A / 24VDC)
* Power supply: from USB port (consumption - 400 mA)
* Windows/Linux free software
* Software examples: VB.NET, Labview, C#.NET, VB6, Python


Description This is Four Channel relay board controlled by computer USB port. The usb relay board is with 4 SPDT relays rated up to 10A each. You may control devices 220V / 120V (up to 4) directly with one such relay unit. It is fully powered by the computer USB port. Suitable for home automation applications, hobby projects, industrial automation. The free software allows to control relays manually, create timers (weekly and calendar) and multivibrators, use date and time for alarms or control from command line. We provide software examples in Labview, .NET, Java, Borland C++, Python.

Features:

* PCB parameters: FR4 / 1.5mm / two layers / metalized holes / HAL / white stamp / solder mask / еxtra PCB openings for better voltage isolation / doubled high voltage tracks
* Power supply: from USB port
* Current consumption: 400 mA
* Chip: __FT245RL__ (important to me)
* Power led: Yes
* Relay leds: Yes
* Size: 77mm x 56mm x 17mm
* Supported by DRM software (Windows and Linux): Yes
* Supported by Denkovi Command line tool (Windows, Linux): Yes
* Android software available (low cost but very useful): Yes

Documentation: http://denkovi.com/Documents/USB4/Current-Version/USB4RelayBoard_UM.pdf

Denkovi command line tool: http://denkovi.com/denkovi-relay-command-line-tool

Denkovi Relay Manager: http://denkovi.com/drm-software
For software examples: please contact with us.

<a href="https://www.amazon.com/Channel-Relay-Output-Module-Automation/dp/B01FSXAJDQ/ref=as_li_ss_il?keywords=usb+relay+linux&qid=1552289445&s=electronics&sr=1-4&linkCode=li2&tag=scotttactical-20&linkId=7350855eb43e93cd655b010f62ee0a1d&language=en_US" target="_blank"><img border="0" src="//ws-na.amazon-adsystem.com/widgets/q?_encoding=UTF8&ASIN=B01FSXAJDQ&Format=_SL160_&ID=AsinImage&MarketPlace=US&ServiceVersion=20070822&WS=1&tag=scotttactical-20&language=en_US" ></a><img src="https://ir-na.amazon-adsystem.com/e/ir?t=scotttactical-20&language=en_US&l=li2&o=1&a=B01FSXAJDQ" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />


### Selection 2

This one seemed realistically working for me.

Though it didn't directly say it this has an __FTDI__ brain on it according to one of the reviews.

<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ss&ref=as_ss_li_til&ad_type=product_link&tracking_id=scotttactical-20&language=en_US&marketplace=amazon&region=US&placement=B009A5246E&asins=B009A5246E&linkId=1bd16a3cf319af76debbee8589b833ea&show_border=true&link_opens_in_new_window=true"></iframe>

From thier posting:

This USB Relay Controller/Data Acquisition Module allows computer controlled switching of external devices as well as full bi-directional communication with the external world (ideal for Data Acquisition applications) using the USB port of your computer. The controller is very flexible and can be used in many custom applications including weather stations as well as temperature monitoring, logging and control as it can be easily connected to temperature and other types of sensors.

Communication Parameters:

* 8 Data, 1 Stop, No Parity
* Baud rate : 9600

* Drivers are available to work with the following operating systems:
* Windows Server 2008 R2, Windows 7, Windows 7 x64, Windows Server 2008,
* Windows Server 2008 x64, Windows Vista, Windows Vista x64, Windows Server 2003,
* Windows Server 2003 x64, Windows XP, Windows XP x64, Windows 2000, Windows ME,
* Windows 98, Linux, Mac OS X, Mac OS 9, Mac OS 8, Windows CE.NET (Version 4.2 and greater)

Commands:

FIRST channel commands:

* OFF command : FF 01 00 (HEX) or 255 1 0 (DEC)
* ON command : FF 01 01 (HEX) or 255 1 1 (DEC)

SECOND channel commands:

* OFF command : FF 02 00 (HEX) or 255 2 0 (DEC)
* ON command : FF 02 01 (HEX) or 255 2 1 (DEC)

THIRD channel commands:

* OFF command : FF 03 00 (HEX) or 255 3 0 (DEC)
* ON command : FF 03 01 (HEX) or 255 3 1 (DEC)

FOURTH channel commands:

* OFF command : FF 04 00 (HEX) or 255 4 0 (DEC)
* ON command : FF 04 01 (HEX) or 255 4 1 (DEC)


Download:

https://s3-ap-northeast-1.amazonaws.com/sain-amzn/20/20-018-909/20-018-909.rar

### Section 3

This one was another option in the case of shenanigans.

It says that it is HID compatible which is another driver layer.

<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ss&ref=as_ss_li_til&ad_type=product_link&tracking_id=scotttactical-20&language=en_US&marketplace=amazon&region=US&placement=B072F6RT6Y&asins=B072F6RT6Y&linkId=5fcfa167ddfff2524dc841f3a85125ba&show_border=true&link_opens_in_new_window=true"></iframe>


* The module uses HID technology, without any driver, plug and play. Support WIN7, XP 32-bit, 64-bit system, easy to use simple. (Can provide development library, if you need, please contact us).
* Onboard square USB interface, stable connection; use of high-performance USB control chip; use dedicated relay driver chip ULN2803, relay work more stable;
* Power outlet and terminal, two access power mode convenient and flexible. After connecting the power, even if the computer shut down or USB from the computer pull out, the relay can also maintain the set state.
* PCB size: 71.6mm * 65.3mm, fixed hole size: 3mm, fixed hole center moment: 67.4mm * 61.3mm.
* Note: Due to the characteristics of the USB protocol, this module is not suitable for use where electromagnetic interference is large! If you want to use, please do electromagnetic shielding measures.


APP Download:
https://www.amazon.com/clouddrive/share/8Qn3vw8915JaZiv5bYzuBJWg1Ic4kibOcus1BhTJcrS

Input voltage: DC 12 V;

* Input current: greater than 300mA;
* Wiring method: NC / COM / NO;
* Relay parameters:
* Maximum control AC 250V, 10A AC load and maximum DC30V 10A DC load;

Module Application:

* Home intelligent switch control;
* Hotel intelligent switch;
* Hotel intelligent electrical control;
* Intelligent greenhouse;
* Shopping malls intelligent switch;
* Company plant intelligent switch;
* Internet cafes regular management;
* Karaoke timing control;
* Networking;
* Industrial equipment;
* Test equipment power control;
* Street lamp management;
* Intelligent management;
* Centralized power management;

Package Inluded:

* 1*4-Channel 12V USB Control Switch Relay Module


### Don't Forget Your Power Cord

These are DC so unless you have a car battery sitting there - make sure to bring your own powah.

<a href="https://www.amazon.com/TMEZON-Power-Adapter-Supply-2-1mm/dp/B00Q2E5IXW/ref=as_li_ss_il?_encoding=UTF8&pd_rd_i=B00Q2E5IXW&pd_rd_r=986df745-4440-11e9-9168-558a5671e079&pd_rd_w=x8LKV&pd_rd_wg=9oR3e&pf_rd_p=6725dbd6-9917-451d-beba-16af7874e407&pf_rd_r=7THBDYX19M60HZNE11VT&psc=1&refRID=7THBDYX19M60HZNE11VT&linkCode=li2&tag=scotttactical-20&linkId=961641b137106ae80bb7f52d46a9ea9e&language=en_US" target="_blank"><img border="0" src="//ws-na.amazon-adsystem.com/widgets/q?_encoding=UTF8&ASIN=B00Q2E5IXW&Format=_SL160_&ID=AsinImage&MarketPlace=US&ServiceVersion=20070822&WS=1&tag=scotttactical-20&language=en_US" ></a><img src="https://ir-na.amazon-adsystem.com/e/ir?t=scotttactical-20&language=en_US&l=li2&o=1&a=B00Q2E5IXW" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />
