---
date: 2016-03-29T16:14:48-07:00
title: Dymo LabelWriter on Mac OSX - JavaScript
url: setup-dymo-labelwriter-mac-javascript
tags: [ software,hardware ]
---

# Setup - Dymo LabelWriter 450 on Mac OSX

The clinic software requires the ability to print labels adhoc and by event. This requires that the client be able to initiate the labels. There are no requirements that the backend server be able to print labels. Thank goodness. That requires something akin to a fulfillment center and probably integration with a 3rd app. Welcome: disparate stand-alone boxes.

## Install App and Drivers

Good job guys. You get a big thumbs up for having a brew recipe.

  brew install Caskroom/cask/dymo-label

After running this I was able to hit the app from the Applications directory.

And then after that I had to retract my praise. The app was well out of date. It might have worked but I wasn't going to test it. I need latest greatest. Please use [github](http://github.com) or some public repository with the uncompressed source. :) Tnx.

## Reinstall Installer

http://developers.dymo.com/2016/01/05/dymo-label-software-version-8-5-3-for-patch-release-macwin/

This got me up to 8.5.3 and support for El Cap.

I did not install the M$ Office support junk. Thanks but no.

## Add Printer

This was simple as well. I went to options and added the printer. Thanks for making that easy Dymo.

# Coding with Dymo Javascript SDK

This SDK wasn't too hard to work with.

I took the [example](http://developers.dymo.com/2011/12/16/printing-qr-code-part-2/) with the included [html](http://labelwriter.com/software/dls/sdk/samples/js/QRCode/QRCode.html) and [javascript](http://labelwriter.com/software/dls/sdk/samples/js/QRCode/QRCode.js). This saved me a ton of time. I have a pretty specific use case so I was able to remove most of the unnecessary code.

## Allow to Run

The browser will allow you to run "DYMO Label" app so you are prompted to allow. Just allow it permanently. Then you will need to refresh so the init can pick up the printer.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Printing from dymo JavaScript sdk <a href="https://t.co/NbwIdx0QtT">https://t.co/NbwIdx0QtT</a></p>&mdash; Scott Tactical (@Scott_Tactical) <a href="https://twitter.com/Scott_Tactical/status/715214655044644865">March 30, 2016</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
