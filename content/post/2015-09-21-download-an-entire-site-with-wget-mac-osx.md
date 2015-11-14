---
title: 'Download an Entire Site with wget - mac OSX'
author: SScott
date: 2015-09-21
url: /download-an-entire-site-with-wget-mac-osx/
categories:
  - DevOps
image: images/homebrew.jpg
---
# Download the Entire Site with wget

If you don't have [homebrew](http://brew.sh/) please install it. It will make all our lives easier.

## Howto

This was kinda simple but I wanted to post it here for reference.

On thing I would like to note is the wait and limit-rate. Make sure you don't trip any throttles or piss off any website owners by leaving the pipes wide open.

```
wget \
     --recursive \
     --no-clobber \
     --page-requisites \
     --convert-links \
     --wait=5 --limit-rate=20K \
     --domains api.yoursite.com \
     --no-parent \
         http://api.yoursite.com/
```

Alternate you can run the mirror command

```
wget -m --wait=5 http://test.com
```

I am sure one can use lynx but this is what I like. And it's handy on the mac.
