---
title: "Installing a USB Relay"
date: 2019-03-18T18:16:54-07:00
url: installing-usb-relay
draft: false
author: SScott
tags: ["car computer"]
comments: true
---

{{% img src="images/car_computer/hid_relay_on.jpg" caption="USB HID Relay" %}}


## USB Relay on Ubuntu Linux

This was fairly easy but not where I wanted to be. I found a library that did a ton of things for me.

Thank you to @darrylb123 for https://github.com/darrylb123/usbrelay

There was a python contribution but it broke the build. I spent a few hours trying to get it to build and gave up and just smashed the ugly.

Wrapping C++ code in python isn't super tough but it takes a lot of time and running through iterations of compilation. Sending it to a process is fairly simple and given the amount of time I will be doing it will give me more time to focus on other things. I'll come back to this later after I'm out of urgent prototype mode.

### USB Relay Driver

With HID I was able to see the device/chip in `lsusb` right away.

I installed the library above from apt and it ran out of the box.

I scripted a tool that will send commands to a sub process. I just need to send and forget. I probably wont use the results of the commands right now.  Each time the application loads I will need to get the names of the devices however because I really don't want that hard coded.  I am hard coding each relay because I would like the ability to control things uniquely.  I'm probably going to use it to turn on seat heaters in the future as well.  

I will say that not everything clicked out of the box.  I had to install a few things. Here are just some highlights to my notes which you might be able to follow and if not there are comments below.


```bash
apt install firmware-b43-installer
apt install git vim openssh-server
systemctl enable ssh
apt install python3
apt install libpython3.7-dev
apt install libhidapi*
apt-get install python3-distutils
apt install python3-pip

git clone https://github.com/darrylb123/usbrelay.git
git checkout tags/v0.4 -b v0.4
```

### Interacting With The Relay

The results come back showing the device with the list of the relays.

Notice this was build with HIDRAW vs HIDUSB lib. I don't know what the differences are but on some platforms they perform differently.

```bash
$> usbrelay
Device Found
  type: 16c0 05df
  path: /dev/hidraw0
  serial_number:
  Manufacturer: www.dcttech.com
  Product:      USBRelay4
  Release:      100
  Interface:    0
  Number of Relays = 4
QAAMZ_1=0
QAAMZ_2=0
QAAMZ_3=0
QAAMZ_4=0
```

I will take the relay names and add them to an array in the code and just replace the numeric ID. The integer at the end is the boolean.

NOTE: It doesn't hurt to send similar signals to a relay. (or doesn't seem to) Meaning if it's on I can send another on and it doesn't do anything. Same with off.  


To get an idea of the code running this:


```python

if __name__ == "__main__":
    print("Relay Trip")

    # get the list of relays

    result = subprocess.check_output(['usbrelay'])

    results = result.decode().strip().splitlines()

    devices = {}
    for res in results:
        key, val = res.split('=')
        devices[key] = int(val)

    print(devices)
    args = parser.parse_args()

    c1 = args.channel1
    c2 = args.channel2
    c3 = args.channel3
    c4 = args.channel4

    for device, state in devices.items():
        if device.endswith(f"_1"):
            subprocess.check_output(['usbrelay', f"{device}={c1}"])
        if device.endswith(f"_2"):
            subprocess.check_output(['usbrelay', f"{device}={c2}"])
        if device.endswith(f"_3"):
            subprocess.check_output(['usbrelay', f"{device}={c3}"])
        if device.endswith(f"_4"):
            subprocess.check_output(['usbrelay', f"{device}={c4}"])


```



Below is the test results at prob 1am so don't mind my groggy voice.

<iframe width="560" height="315" src="https://www.youtube.com/embed/KX3ZT6bbSsg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## USB Relay on Macbook Pro

I didn't really know what I was getting into and I do all of my initial research on Mac. So I decided to start there.  

Everything is easier on Mac right?

### Chipset Variants

There are two variants of USB relays that I am working with. An FTDI and HID version.

The HID version is supposedly able to be picked up by the system as soon as it's plugged in so that is what I started with.

There is no `lsusb` so I had look up what Mac uses.  This site helped me out: https://pim.famnit.upr.si/blog/index.php?/archives/165-OS-X-equivalent-to-lsusb.html


  system_profiler SPUSBDataType

The data did show me that I was nested.  It went through a USB 3.0 hub to a 2.0 hub then down to the device.  There was a lot of other things being picked up here that were overlocked.  At first I wasn't sure what I was looking for then saw the name which matched the board.  I kinda expected more of a GUID so IDK what will happen if I plug in more of these.


```
USB 3.0 Bus:

Host Controller Driver: AppleUSBXHCISPT
PCI Device ID: 0xa12f
PCI Revision ID: 0x0031
PCI Vendor ID: 0x8086

  USB2.0 Hub:

    Product ID: 0x2813
    Vendor ID: 0x2109  (VIA Labs, Inc.)
    Version: 90.11
    Speed: Up to 480 Mb/sec
    Manufacturer: VIA Labs, Inc.
    Location ID: 0x14600000 / 15
    Current Available (mA): 500
    Current Required (mA): 0
    Extra Operating Current (mA): 0

      USB 2.0 Hub:

        Product ID: 0x0801
        Vendor ID: 0x1a40  (TERMINUS TECHNOLOGY INC.)
        Version: 1.00
        Speed: Up to 480 Mb/sec
        Location ID: 0x14640000 / 16
        Current Available (mA): 500
        Current Required (mA): 100
        Extra Operating Current (mA): 0

          USB 2.0 BILLBOARD             :

            Product ID: 0x0100
            Vendor ID: 0x2109  (VIA Labs, Inc.)
            Version: 2.01
            Serial Number: 0000000000000001
            Speed: Up to 480 Mb/sec
            Manufacturer: VIA Technologies Inc.         
            Location ID: 0x14644000 / 20
            Current Available (mA): 500
            Current Required (mA): 100
            Extra Operating Current (mA): 0

      USBRelay4:

        Product ID: 0x05df
        Vendor ID: 0x16c0
        Version: 1.00
        Speed: Up to 1.5 Mb/sec
        Manufacturer: www.dcttech.com
        Location ID: 0x14620000 / 25
        Current Available (mA): 500
        Current Required (mA): 20
        Extra Operating Current (mA): 0
```

And there it is.  `USBRelay4`

{{% img src="images/car_computer/hid_relay_on.jpg" caption="Mac USB system profile" %}}


### System Report

There is another way to get to this

1. About This Mac
2. System Report
3. Hardware > USB


{{% img src="images/car_computer/system_hardware_usb.jpg" caption="USB Relay On" %}}


### Brew U

Apparently I could have just installed via brew. :|


  brew install lsusb

```bash
$> lsusb
2019-03-18 18:36:56.382 system_profiler[48402:1885449] SPUSBDevice: IOCreatePlugInInterfaceForService failed 0xe00002be
Bus 020 Device 015: ID 2109:2813 VIA Labs, Inc. USB2.0 Hub
Bus 020 Device 016: ID 1a40:0801 TERMINUS TECHNOLOGY INC. USB 2.0 Hub
Bus 020 Device 020: ID 2109:0100 VIA Labs, Inc. USB 2.0 BILLBOARD  Serial: 0000000000000001
Bus 020 Device 025: ID 16c0:05df 16c0 USBRelay4
Bus 020 Device 017: ID 05e3:0608 Genesys Logic, Inc. USB2.0 Hub
Bus 020 Device 019: ID 046d:c52b Logitech Inc. USB Receiver
Bus 020 Device 018: ID 05ac:024f Apple Inc. Matias Backlit Keyboard  Serial: FK318VUS
Bus 020 Device 027: ID 05ac:12a8 Apple Inc. iPhone  Serial: 9dac5dde6e85ef8007a86a42a2785fea667e8bff
Bus 020 Device 000: ID 05ac:8600 Apple Inc. iBridge
Bus 000 Device 001: ID 2109:0813 VIA Labs, Inc. USB3.0 Hub
Bus 000 Device 002: ID 058f:8468 Alcor Micro, Corp. Mass Storage Device  Serial: 058F84688461
Bus 000 Device 001: ID 1d6b:ISPT Linux Foundation USB 3.0 Bus
Bus 000 Device 001: ID 1d6b:CIAR Linux Foundation USB 3.1 Bus
Bus 001 Device 001: ID 1d6b:CIAR Linux Foundation USB 3.1 Bus
```

This is much easier to read anyway.

### Talking To USB Relay On Mac

This is not going to be as easy as just sending bits over a COM port. I have to walk through a few layers of device controls.


https://developer.apple.com/library/archive/documentation/DeviceDrivers/Conceptual/HID/intro/intro.html

There are some USB specific standards defined that I wont spend time to go into right now:

https://www.usb.org/hid

And here I am stuck. There are no drivers for it so I will bail and go work on Linux for a bit.

Sorry for the false hope.
