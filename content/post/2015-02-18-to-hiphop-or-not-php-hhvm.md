---
title: 'To HipHop or Not - PHP and HHVM'
author: SScott
date: 2015-02-18
url: /to-hiphop-or-not-php-hhvm/
categories:
  - Uncategorized
---
We are discussing the plausibility of using HHVM inside this current infrastructure.
  
Our requirements are not very application server CPU intensive so it isn't immediately apparent why this would be beneficial, but for investigations sake I wanted to go through the diligence. 

## Short History

![HHVM][1]

Facebook, our Ominous big brother gave us a consolation prize for freely giving away just about all that most people have online that has any value: their personal information. On the topic of sheeple for another day. For today, we thank you Facebook. May your stock price soar to the stars. 

I wanted to know what the differences between [HHVM][2] and HipHop Orig was if there was any. HPHPc was the original source to source compiler that converted to C++. There were a lot of inherent problems there and the team later decided to switch tracks and make a JIT virtual machine instead: more formally [HipHop Virtual Machine][3] known as HHVM. I personally like this approach much better due to the portability. At some point I'll write about my romance with the idea of compiling in tools for [AOP][4]. 

Interestingly enough VKontakt is coding their own translator right along side Facebook. [KPHP][5]. I guess old international habits die slowly. 

### Hack (programming language)

One of the best things I think this paradigm added is the enhanced [Hack][6] programming language. It gave PHP a static or dynamic type syntax. For those who complain about PHP's loose typing, well here you go. 

## Benefits

What are the benefits to having HipHop in place?

**Performance**

That is about the only noteworthy thing I can see. Having Hack around is nice, but my guys are not going to change any time soon to use this. PHP is built to be phast and loose. Fast as in "can you have this ready today" sadly. I'd rather have things up and running fast and deal with standards at the QA/unit test layer. Working with the majority of the code being legacy negates the benefit also. 

## Our stack

Right now it's so vanilla that it is disgusting.
  
Ubuntu in AWS
  
PHP 5.5.x
  
Mysql 5.6
  
Home strung framework
  
Laravel integrated
  
Memcached

Loaded Modules:
  
Core
  
date
  
ereg
  
libxml
  
openssl
  
pcre
  
zlib
  
bcmath
  
bz2
  
calendar
  
ctype
  
dba
  
dom
  
hash
  
fileinfo
  
filter
  
ftp
  
gettext
  
SPL
  
iconv
  
mbstring
  
pcntl
  
session
  
posix
  
Reflection
  
standard
  
shmop
  
SimpleXML
  
soap
  
sockets
  
Phar
  
exif
  
sysvmsg
  
sysvsem
  
sysvshm
  
tokenizer
  
wddx
  
xml
  
xmlreader
  
xmlwriter
  
zip
  
PDO
  
apcu
  
curl
  
gd
  
intl
  
json
  
mcrypt
  
memcached
  
mysql
  
mysqli
  
pdo_mysql
  
readline
  
redis
  
xmlrpc
  
mhash
  
apc
  
ZendOPcache

## Next Steps

I will be doing some performance tests coming up IF we are able to get this into play.
  
My plan is to run load test against our normal branch and then

 [1]: http://hhvm.com/wp-content/themes/hhvm/hhvm.png
 [2]: http://hhvm.com/ "HHVM"
 [3]: https://en.wikipedia.org/wiki/HipHop_Virtual_Machine "HipHop Virtual Machine"
 [4]: https://en.wikipedia.org/wiki/Aspect-oriented_programming "Aspect Oriented Programming "
 [5]: https://en.wikipedia.org/wiki/KPHP "KPHP"
 [6]: https://en.wikipedia.org/wiki/Hack_%28programming_language%29 "Hack"