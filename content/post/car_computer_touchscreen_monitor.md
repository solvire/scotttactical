---
title: "Car Computer Touchscreen Monitor"
date: 2019-03-11T21:15:12-07:00
draft: false
author: SScott
url: car-computer-touchscreen-monitor
tags: ["car computer"]
comments: true

---

How do you control your new custom Linux powered car computer? With a touch screen monitor obviously. And maybe a bluetooth keyboard and mouse.

I would like this to feel like I am using a [Steampunk](https://www.urbandictionary.com/define.php?term=steampunk) hacker version of a Tesla.  

{{% img src="images/tesla-streamliner.jpg" caption="Tesla Streamliner Concept" href="https://www.greencarreports.com/news/1093773_icon-helios-is-gorgeous-tesla-powered-electric-streamliner-concept" %}}

Well maybe not all that.  

Maybe more like this:


{{% img src="images/race_truck_dash.jpg" caption="Race Truck Dash"  %}}

## Touch Screens

I started a similar project about 6 years ago on another vehicle. I wasn't able to get a monitor installed on that vehicle in the center and felt like it would be obstructive.  Instead I put in a navigation system that was about 11" and placed it in front of the passenger.  Since then Tesla Motors came out and made their entire center console a touch screen.  Now I realize I can be obnoxious in the center of my console for no good reason and people will dig it.


{{% img src="images/tesla-dashboard.jpg" caption="Tesla Dashboard"  %}}

Honestly this is kinda ugly. It's just a huge monitor that doesn't fit into any design constraints. In car that is supposed to be pretty I guess it doesn't matter.  This is a perfect example of forcing a customer to compromise for functionality and not worrying about the art of it.  

## Feature Requirements

This is pretty simple and I will try to rank my requirements by importance.

1. durability
2. cost
3. size
4. power consumption
5. picture quality
6. HDMI

*In business parlance:* I am going to beat this up probably, but don't have a ton of money to spend on a super low power rugged military console. Besides those military and police ones have crappy screens and use proprietary connectors.  

Nice to haves:

* big screen (gaming / videos)
* speakers built-in (for adhoc usage)
* auto sleep
* dimmer
* mountable case
* durable shell
* front facing controls
* hidden plugs

## Capacitive vs. Resistive Touchscreens

#### A capacitive touchscreen:

A capacitive touchscreen is made of two layers of glass, coated with a conductive agent, like iridium tin oxide.
The conductor agent reacts to the touch of a human finger or special-tipped stylus on the screen. This causes a change in the local electrostatic field and indicates to the system exactly which area, number, or icon on the screen has been touched. A capacitive touchscreen also supports multi-touch—e.g., simultaneous pressing on an icon and enlargement of an image on the screen.

* Offers easy, flexible operation.
* Touts a higher degree of contrast and thus can be seen more easily.
* Facilitates more accurate input.
* Features enhanced durability.
* Future-proof - becoming more popular

> A capacitive touchscreen that is scratched, pierced, or cracked will continue to operate. This can occur if employees try to operate the device with something other than their finger or stylus, if they tap the glass too hard, or if a mobile device is dropped. This is not true of a resistive touchscreen, which in most cases stops working whenever the surface is damaged.

#### Resistive Touchscreen

* Is most widely accepted
* It is less expensive
* Reacts to multiple types of touch. gloved or ungloved fingers
* More Sensitive

A resistive touchscreen can also register input from a fine point of contact because it offers more sensors per inch than a capacitive touchscreen.

A resistive touchscreen is comprised of two flexible layers of material with a layer of air in between. It registers input (the precise location of the touch) when a small amount of pressure is exerted on the top layer, enough for it to make contact with the bottom layer. Because the two layers of material used in a resistive touchscreen are synthetic instead of glass, its surface is susceptible to scratching or wear than the surface of a capacitive touchscreen.

##### I Chose Capacitive

I thinks I am pretty much settled now. These are the two most popular and what I have access to choose from.


## Screen Types - TFT vs OLED

The greatest portion of monitors are probably going to be Thin Film Transistor (TFT).  Though there are some Organic Light Emitting Diode (OLED) monitors I didn't see any of them.

https://www.techwalla.com/articles/what-is-a-tft-touch-screen


## Optimal Size

Because this is going to be stuck in the middle of the console on the truck I need to keep it within a reasonable size.  Originally I was going to use a Google Nexus 7, but things have evolved a lot since then.  I think the max capacity for that area is 13" viewable. Ideally I think a 11" screen would do well.

## Form Factor

One of these Raspberry Pi modules would be great though they will come with quite a bit more work to fabricate a case for it. Also they don't tend to be very big.

{{% img src="images/7inch_cap.jpg" caption="7-Inch-1024x600 Capacitive Touch Screen" href="http://wiki.52pi.com/index.php/"  %}}


At 7" there isn't a lot to be expected.

<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ss&ref=as_ss_li_til&ad_type=product_link&tracking_id=scotttactical-20&language=en_US&marketplace=amazon&region=US&placement=B075QCXLPF&asins=B075QCXLPF&linkId=ac6bb824f0310ee27078ca9f29dbda25&show_border=true&link_opens_in_new_window=true"></iframe>

* Extend Two USB HOST Ports；Resolution up to 1024 x 600; USB Capacitive touch control ;Free-driver, Plug and Play;
* Supports Raspbian, Ubuntu Mate, NOOBS with RaspberryPi; Supports Debian, Angstrom with BeagleBone; Supports Windows / Ubuntu / Mac with PC; Supports Intel-Processor Base MiniPC;
* ULP (Ultra Low Power) consumption backlight
* Package includes: 1 x 7 Inch Capacitive HDMI Display, 1 x 30cm High Quality HDMI cable wire ,1 x MicroUSB Cable wire

I see that is supports ubuntu mate so that is a good sign though I haven't looked further.



* Power: 5V Power via USB Micro
* Current: Max 500mA
* Display Type: 7 inch TFT LCD


{{% img src="images/7inchwithmark.jpg" caption="7-Inch Capacitive Touch Screen"  %}}



* Resolution: 1024x600
* Touchscreen: USB capacitive
* Touch points: 10 points maximum
* Interface: HDMI & USB 2.0 Full Speed
* Brightness：250 cd/m² (Typ.)
* Contrast Ratio:500:1 (Typ.) (TM)
* View Angle: 70/70/50/70 (Typ.)(CR≥10)
* Respones Time: 10/15 (Typ.)(Tr/Td) ms
* Dimensions: 177.06mm x 113.09mm x 15.2mm
* Weight without package: 230g
* eight with package: 350g

#### Can I Buy A Tesla Screen

I looked at a few Pi's before I decided to just see what was in the Tesla 3. Apparently on the open market they are going for north of $1300 right now. That is more than a good TV. People are crazy.  And they are buying them in orders of 20k at a time.


{{% img src="images/tesla_dash2.jpg" caption="Tesla 3 Screen"  %}}


It is a 15 inch screen however.  And I love the night mode.  It's always night mode for me.

{{% img src="images/tesla_dark_mode.jpg" caption="Tesla 3 Screen - Night Mode"  %}}


#### A Potential Loss

This one had potential.

<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ss&ref=as_ss_li_til&ad_type=product_link&tracking_id=scotttactical-20&language=en_US&marketplace=amazon&region=US&placement=B01H04GENA&asins=B01H04GENA&linkId=7b351a46d6ff05552c8aae499c93cfb3&show_border=true&link_opens_in_new_window=true"></iframe>

Then I read the specs.

Warm Tips :

* ❤ The touch function ONLY can be used after monitor hooked up to pc with driver installed via USB cable.
* ❤ Driver download link (according to your computer system): http://www.eeti.com.tw/drivers_Win.html
* ❤ Video link for driver installation method : https://www.youtube.com/watch?v=vmg8W9bxpvw&t=4s
* ❤ Please do 4-point calibration before use touch function.


This TOGUARD 10.1 inch IPS Touchscreen Monitor has a compact and sleek design for connecting with various applications such as laptop, game console, computer, CCTV security camera,etc. Ultra lightweight and slim for great portability, making it perfect for business presentations and the frequent traveler.

Nope.


#### Another Pi


This one is a strong toss up.

At $175 it's not an easy decision

Touchscreen Monitor HDMI VGA Display 12.3-inch 1600×1200 Resolution for Industrial Equipment Built-in Speaker VESA Mounted for Computer Laptop Raspberry pi

<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ss&ref=as_ss_li_til&ad_type=product_link&tracking_id=scotttactical-20&language=en_US&marketplace=amazon&region=US&placement=B07MV6X7ML&asins=B07MV6X7ML&linkId=b54436ee48027bfb3f09324c7f8e069d&show_border=true&link_opens_in_new_window=true"></iframe>


### Supplier SunFounder


The monitor produced by SunFounder looked very appealing. Its promise of supporting so many versions went a long way with me.

https://www.sunfounder.com/

https://www.sunfounder.com/10-1-touch-screen.html



Features

{{% img src="images/sunfounder_10.1_touch_screen_for_raspberry_pi_lattepanda_beagle_bone_01.jpg" caption="Sun Founder 10.1"  %}}

* HIGH RESOLUTION - The 10.1 inch IPS touchscreen LCD monitor with high resolution of 1280×800 pixels.
* PLUG AND PLAY - Just connect the control board and the screen by an HDMI cable and it can work immediately, needless of driver. For more information, please refer to: wiki.sunfounder.cc/index.php?title=10.1_Inch_Touch_Screen_for_Raspberry_Pi
* UNIVERSAL FASTENING POSITION - Supports Raspberry Pi 3, 2 Model B, and RPi 1 B+, LattePanda, and PC
* MULTIPLE APPLICABLE OS - Supports Raspbian, Ubuntu, Ubuntu Mate, Windows, Android, Chrome OS. And you can download 3D Stand Installation Manual from the selling page.
* THOUGHTFUL DESIGNED - Keeps itself flat with 4 copper standoffs of the same height at the back case, also for fastening.

{{% img src="images/sunfounder_10.1.jpg" caption="Sun Founder 10.1 Monitor"  %}}

Technical Details

Introduction

> This SunFounder Touch Screen is a 10-point IPS touch screen in a 10.1'' big size and with a high resolution of 1280x800, bringing you perfect visual experience. It works with various operating systems including Raspbian, Ubuntu, Ubuntu Mate, Windows, Android, and Chrome OS.
For more information, please refer to: http://wiki.sunfounder.cc/index.php?title=10.1_Inch_Touch_Screen_for_Raspberry_Pi

Package Included

* 1 x 10.1'' IPS Touch Screen
* 7 x M2.5 x 14.4 Copper Standoff
* 2 x M2.5 x 22 Copper Standoff
* 2 x Wrenches
* 1 x HDMI Cable
* 1 x Micro USB Cable
* 1 x USB Touch Screen Cable
* 1 x 12V1.5A Power Adapter

This thing looks delicate. I would have to shield it for sure.

{{% img src="images/sunfounder_specs.jpg" caption="Sun Founder 10.1 Specs HDMI"  %}}

##### Bad Reviews

After reading a ton of reviews I don't think I can trust myself with this. The touchscreen portion doesn't seem like I can get it out of the device and I would have to create my own case for it.


### A Car monitor


{{% img src="images/car_monitor1.jpg" caption="Car monitor"  %}}


<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ss&ref=as_ss_li_til&ad_type=product_link&tracking_id=scotttactical-20&language=en_US&marketplace=amazon&region=US&placement=B077M6613Y&asins=B077M6613Y&linkId=2fa16d2057b69f16deeb9cd0ba16a519&show_border=true&link_opens_in_new_window=true"></iframe>



* CAPACTIVE TOUCH SCREEN: This 10.1 inch touchscreen monitor uses capacitve touch panel, it’s more durable than resistive touch screen. Easy to operate by fingers without install any software. You will get more fun with entertainment
* BIG IPS SCREEN: Slim design 10.1 inch ips wide screen led display with 1280x800 resolution and quick 2 ms response time delivering smooth video display. 16:9 screen ratio
* MUTI-FUNCTION: with VGA/HDMI/VIDEO inputs, it can be used as car backup monitor, desktop computer monitor, external monitor, raspberry pi display touch screen monitor, mini size bus TV monitor, photo scanner or video display. USB port for 10 points capacitive touch
* HIGH RESOLUTION PICTURE: Support 1280*800 pixels with ips panel, it delivers higher resolution and clearer picture. The color is more realistic and vivid. Wide viewing angle and fast response speed brings visual enjoyment
* EASY TO USE: This portable computer monitor provides VESA holes for mounting on the wall, save space. Package contents 1x10.1" car monitor, 1xstand, 1xpower supply, 1xVGA cable, 1xsticker. Note: You are kindly suggested to ask a specialist or go to 4s car store for installing if you do not know how to install


Obviously this is a foreign made monitor. The information seems like ESL.



### iPad Monitor?


http://avatron.com/applications/air-display/



Virtual Screen:

https://github.com/kbumsik/VirtScreen

Yeah. This aint gonna happen.



## Conclusion

This took a lot longer than I expected. But what I did learn:

* The small form factor HDMI touch screen market is wiped out by the tablet market
* Either small monitors are too small for hobbyists or too expensive and ugly for industrial apps
* People still don't hack their car electronics because it's a ton of dark magic and mechanics are superstitious
* We need to build more prototyping tools in the USA


At the end of the day I went with SunFounder because I felt like they might have a good prototype tool and their support department seemed to be responsive. If I made a mistake then I will purchase another smaller model and come back later.
