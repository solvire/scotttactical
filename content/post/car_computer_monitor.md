---
title: "Car Computer Monitoring"
author: SScott
date: 2019-07-06T21:32:16-08:00
draft: false
url: car-computer-monitoring
image: /images/cc-intro.jpg
tags: ["car computer"]
comments: true
---

## Monitoring

My problem at this point is how to turn on/off the heavier algorithms and not run the cameras all the time. Even right now I am showing that the power consumption is around .2kw/h which is a bit much to add anything into.  

With the current consumption it looks like I need to have some better power management. Something I can change on the fly or be intelligent about when to be on/off.  


I need to have a sentry running that is only partially watching.

![Arduino](/images/jarvis.jpg)



## Ubuntu Monitor

There appears to be a nice monitoring app that is on github.

https://github.com/Motion-Project/motion

I think it is going to track change in screen - so movement.

  apt install monitor

I think that was about all I needed to do.  


### Monitor Configuration

> Motion is able to process images from many different types of cameras. The following is brief overview of the process to set up the Motion software.

So here we go.

I am pretty sure my cam is a standard v4l2 device.

Also based on the docs I realize that i have to be selective with the use of the camera.

> USB cameras take a lot of bandwidth. A USB camera connected to a USB2 port or hub consumes virtually all the bandwidth that the port can handle

I wanted to have an internal facing camera but that seems like I might need to have something else running inside instead.

### Test Run


The first time I started it I lost my connection and couldn't get it to stop. I had to log in and kill the process.

After back in I was able to set up `htop` and tail the log file.  I noticed that when it started it found the OS settings I had put in for my camera.  It pulled in all the configs as I hoped.

  [1:ml1] [NTC] [VID] [Jul 06 13:23:27] v4l2_scan_controls: 	"Gain", default 0, current 0
  [1:ml1] [NTC] [ALL] [Jul 06 13:23:27] image_ring_resize: Resizing pre_capture buffer to 1 items
  [1:ml1] [NTC] [STR] [Jul 06 13:23:27] http_bindsock: listening on 127.0.0.1 port 8081

I had to open up a port for this. I wasn't sure what it was.

  ufw allow 8081/tcp

### Running As A Service

I'm going to start this up and run it live for now.  

  service motion start


## The PIR Solution

### Tutorials


https://randomnerdtutorials.com/arduino-with-pir-motion-sensor/

https://www.adafruit.com/product/705?gclid=CjwKCAjwgqbpBRAREiwAF046JVF__aywU2zx1w8WLs_QXnkcjLSgXeUxiFxP795qczBvQ4wzRaIc_RoCD1cQAvD_BwE



https://github.com/koenieee/WakeOnLan-ESP8266


### Wake Controls


https://github.com/koenieee/WakeOnLan-ESP8266

https://arduino.stackexchange.com/questions/45738/arduino-esp8266-to-put-pc-to-sleep-and-wake-it-up

https://www.hackster.io/zvonko-bockaj/wemos-esp8266-remote-pc-switch-062c7a


#### Network Tools


I thought about just using wifi to send the wake on LAN signal. That seems risky as I don't want to relay on both being connected. I could also use bluetooth and serial. But I don't trust bluetooth on my device with the current ubuntu version.

I'm also trying to not use a ton of power. If the arduino is always connected then it's eating up power. A signal from serial isn't anything more than what was already going through the USB.

Something like this could bolt on but an extra $45 isn't worth it to me.

https://store.arduino.cc/usa/arduino-uno-wifi-rev2

![Arduino Wifi](/images/arduino_wifi.jpg)

### Keystrokes for Different Folks

What I tried near the end of my searching for wake specific commands I figured it would be okay to emulate a keyboard. Obviously this is not ideal but it seems like a fun thing to at least try.

Keyboard.h reference https://www.arduino.cc/reference/en/language/functions/usb/keyboard/

Bah.

Looks like Arduino Uno is a slave USB only and I would have to have a USB host shield for it. 
