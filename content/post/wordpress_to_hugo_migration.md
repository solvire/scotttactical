---
date: "2015-10-21T15:39:13-07:00"
title: "Hugo: A replacement for Wordpress"
url: /hugo-a-replacement-for-wordpress/
categories:
  - Software
tags: [go, golang, hugo, wordpress, blogging, software, programming]
---


# Hugo: A Replacement for Wordpress

## TL;DR

- I researched go
- Found Hugo
- Setup a test
- Migrated my Wordpress instance
- Launched DigitalOcean Droplet
- Deployed

Total time: _6 hours_

## Continued:

My problems started almost a year before I took up this cause. At the time I only had 2 Wordpress sites. Very very low traffic.  Only a couple users a day.  They were mostly place holders for business sites.  

## Wordpress is hungry

What was annoying about the case was that they would randomly _carsh_! I realized they were running _out of memory_. I couldn't figure out why because I just wouldn't let myself believe that a couple instances of Wordpress were enough to run out of memory. It was an AWS box running with .5GB of memory and some swap space. I can't remember what. Maybe I was just too optimistic. 


I reimaged the server, installed several performance plugins, cached anything I could, but still it would eat memory like a lonely fat girl at a buffet. Every couple days my monitor would go off telling me the site was down. The monitor wasn't in place immediately because I didn't think I needed one. It was only after the site had been offline for a couple days before I realized that I had to get a monitor. 


Well eventually I decided it just needed more hardware. I went to 1G of memory for the 2 instances. That carshed as well. It was like watching the movie Carsh in slow motion. I added a couple gigs of swap, but then aws started acting funny and it would fill up the memory immediately. I then went to 2G ram and 2G of swap. Still - Carshon Daily show! 

## It's the Future Already

It's 2015. In honor of 2015 and #BackToTheFuture day I am getting over 2000's technology and moving on to something new. 

_Blogs should fast and light_ and should be able to run in the fog. Static, and with out short codes. Gawd! And hoverboards. 


# So Starts My (Late) Journey


## My Requirements

- Easy markup (or markdown) 
- Lite - less than 500M of memory required 
- Static (optional but nice)
- No DB or a lighter option
- Image manipulation or gallery ease
- Simple enough a business person can (ha this isn't the future you are looking for)
- Authentication layers 
- SEO items
    - Sitemap
    - Metatags
    - Links
- Multiple environment friendly (dev/stage/prod)
- PERFORMANT fast
- Templates (market)
- Multi-site management (please?)

## Languages - PREPARED TO FLAMED! 

- PHP - too slow - boring - part of my problem already 
- Python - Interesting but everyone wants to use django. Kinda heavy for this
- Ruby - pretty good but still kinda foreign to me
- Go - I wanna learn it but where are the projects 
- Java - swatting at flies with a sledge hammer
- Scala - eh... i liked this idea but still too big 
- C++ - Not a masochist
- Perl - Not unless you say perl in a French accent every time 
- Node.js - I will not allow JS on my backend, it's unnatural 


Given my above list of languages I kinda forced myself into a sector.  

### Languages - Decisions 

#### Ruby

I really liked [jekyll](http://jekyllrb.com/docs/home/) and might have gone with it if Ruby wasn't such a foreign concept to me. And I haven't decided if I want to jump in and learn it completely. So not this time gems. 

#### A Shot at Python

I have a ton of experience with PHP. They are all about the same. They can get okay performance if you cache everything but they are just too heavy. And it's PHP. I'm over it. Drupal. Seriously it's 2015. That thing should have died 10 years ago.  Are you still driving your subaru brat? 

I've used python before and I did give it a good run, but [Django](https://www.djangoproject.com/) is just too big IMO. A blog is simple. It needs to stay simple. Plus they are trying to recreate Wordpress in all of its glory. No thanks. 

To be fair to python, I spent a little time going through the implementation of [Mezzanine](http://mezzanine.jupo.org/) and [Django-CMS](http://www.django-cms.org/en/).  Still. Too grande. 

#### Java et al

I have spent time before researching Java and C++ CMS programs. They are probably okay for monolithic enterprises who need some sort of back stroking to know they used a dump truck with a Cadillac interior to go pick up the groceries.  When 500 people will be working on it and you need a 20 step approval process I guess. I digress. 

# Starting with Go

Ok fine. Maybe now's my chance to play with [Golang](https://golang.org/). I was looking for a project for it so let's give this a try. 

So far my implementation ideas are:
- roll my own
- wrap up a framework 
- use a designed blog framework 


## Some Frameworks

I really liked a few of the frameworks, but as time went on I decided to see if I could find something lighter. But for records sake here are the samples I looked at 

- http://revel.github.io/
- http://beego.me/
- http://martini.codegangsta.io/ 

BTW: Martini looked really cool. Light learning curve. I almost went with that, but felt like I could find better features in a purpose built app. 

## A Blog Solution

After meandering around with the frameworks I felt like I wanted to try something more stripped down. So I looked at micro sites and Hugo https://gohugo.io/ stood out.  I figured I would know in a couple hours if it work work or not.  


# Hugo: Quick Start

Installing go is awesome on mac. If you have a mac and do not have [homebrew](http://brew.sh/) - shame. 

    brew install go 
    
Installing hugo as awesome. 

    brew install hugo 
    
Creating a new site was extremely simple. 

    mkdir newsite
    cd newsite
    hugo new site . 
    hugo new about.md
    hugo new post/first.md
    git clone https://github.com/dim0627/hugo_theme_beg themes/beg
    
Edit `config.yaml` -- see my example 
Add `theme = "beg"` 

Start the serve:

    hugo server --buildDrafts --watch

# Conclusion

This was very painless. I am kinda surprised. I was a little hesitant to get in here. Setting up virtual hosts and getting the code out there wasn't elegant but wasn't hard either. I just checked out my repo on the server. 

I am going to start transfering some of my other blogs to this when I have the chance. I might even do something sophisticated to the sites that are more or dynamic or colorful. 

Go Golang! 
    