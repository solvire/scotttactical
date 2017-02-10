---
date: 2017-02-09T16:00:07-08:00
draft: false
title: "eMail In A Box: Setup"
comments: true
tags: [ technology ]
---

# Test Drive: Mail In A Box

# TL;DR

I set up [Mail-in-a-Box](https://mailinabox.email/) and it was a quick and painless experience. 

# Preface


I am tired of managing so many gmail and outlook accounts. Those $5/mo bills really eat at me. So I wanted to try something simple. I got goosebumps when I saw this and had to try it.

I'll also preface that I was a professional email list manager and built an email service platform that was sending/receiving greater than 20 million emails a day. This is obviously much different, but it's cool to work in low volume transactional environments. I also hate HATE managing email.


# Pre-setup

Here are a couple details about my stack.

I am hosting on http://dtac.io cloud VPS with the following specs.

- Ubuntu 14.04 LTS
- 2GB memory
- 40GB HD
- 1 local private ip
- 1 public ip
- 1 ipv6 public
- 1 piv6 private


![DTAC Cloud Instance](/images/mib1.png)

Make sure to update ubuntu with all the latest fixes. My SSH keys and all that stuff were already deployed with my personal images.

Let's Begin

# Domain Configuration


I am using [Amazon AWS SES](https://aws.amazon.com/ses/) on their free tier to handle the transactional outgoing email, so this is mostly for incoming mail. If you have dealt with deliverability this is a huge thing for me.

I am also using [Amazon Route 53](https://aws.amazon.com/route53/) for managing the DNS. It's free and I don't want to deal with name servers.

I created an A record for box.theduber.club to my IP. I then set the hostname of the box locally. Make sure to set up reverse DNS as well. https://aws.amazon.com/premiumsupport/knowledge-center/route-53-reverse-dns/

Waiting for your ISP to get rDNS might be the longest thing.

For those who wrote the documentation. It was dialed down a little much. It actually took longer to set up because of the dummyproofing that was going on.

# Installation

As root:

    curl -s https://mailinabox.email/setup.sh | sudo bash

It gave me a nice TUI to go through graphic-ish setup.

![DTAC Cloud Instance](/images/mib2.png)

![DTAC Cloud Instance](/images/mib3.png)

# Configuration


You should be able to log into your console. https://box.yourdomain.com/admin


It will tell you what it is missing. The [Let's Encrypt](https://letsencrypt.org/) feature is great. Totally love that part! Seriously, it saves days of my life.


# Conclusions

I'm totally into this. Thanks to https://twitter.com/mailinabox for all the great work compiling this thing.
