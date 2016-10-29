---
date: 2016-10-28T20:07:57-07:00
draft: false
title: 'Why We Quit OpenStack: or How I Lost 2 Months of My Life'
url: why-we-quit-openstack
image: images/openstack.jpg
tags: [ tech, data, devops ]
comments: true
author: solvire
---

## Backstory

Let me begin by saying that given the proper talent pool, financial resources, and time; OpenStack probably isn't bad for some people. For most institutions it is just _wrong_.

I will probably write another article that outlines all the questions that I should have asked before starting this. My assumptions were not all quite there, but I did have a sneaking suspicion given a couple very relevant experiences.

Several people asked me about a way to do big data(ish) at an affordable price. I enjoy owning hardware and infrastructure and from a business perspective that is a fairly decent endeavor in terms of static equity. I was bored with coding. The two of those items intersected and I decided to take on the task of bringing in some data clients and see if I could beat the services of other competitors and give them a better experience.

Disclosure: This site is currently running on our openstack deployment in [DTAC's](http://dtac.io) private cloud

.
.


![Full OpenStack](/images/full_openstack.jpg)

# Cloud Red Flags

> Where there are _clouds_ of smoke, there is probably fire. - An Indian Truism

## It Took Forever

I witnessed an ambitious project slide face-first into the blue and white parking stall of the private cloud mall. Then later used as leverage out every participant. I mostly attributed the breakdown to lack of time resources, OS talent and political infighting.  _nerds (heart) aws_ but more on that elsewhere.  Given those red flags I figured my sysadmin abilities would be able to figure things out and surpass them.

The project took the best part of a year and I don't think was every really fully consuming of all the infrastructures.

My response: I got sysadmin skills and no politics. I've never not been able to raise a datacenter infrastructure.

## OpenStack Hate Speech

There was plenty of hating over OpenStack. More specifically there was a lot of negative commentary about Nova, Neutron and Cinder. Basically the heart of the application.

My response: I kinda need those bells and whistles so it's worth dealing with monolithic bloat because that's my only option.

## Nerds (heart) AWS

> When there is blood in the streets, buy land. - Contrarian Invetors' Proverb

Searching for OpenStack talent was like looking for unbias political trends on twitter. It just ain't there.  Techs not only didn't know it well, but most applicants that had it on their resumes didn't want to want to deploy it. Out of every 50 consultant I talked with about private cloud work, 49 said they could help me set up with Amazon AW$.  It is entirely confusing to ask someone to help you with your private cloud and they offer to help what is essentially a competitor.

A side note: Most tech professionals also said they were getting a "great deal" at Amazon. No financial officer I talked to shared this sentiment. Food for thought.

My response: Well most nerds have near-0 business strategy. Also this indicates there is a massive gap in talent so I'd like to be here.


## Babylon Fortuna ergo Enterprise-Ready

The codebase is huge. And kinda old at this point. In internet years it's about 50 years old.

My response: It is mature enough to use. I should be ashamed of myself. I deployed IBM Websphere and should have known better.

## It is Complicated

![It's Complicated](/images/fb_complicated.png)

Look at the diagram. Seriously Siri WHERE IS MY CAR!?!?!

![OpenStack](http://docs.openstack.org/icehouse/training-guides/content/figures/5/a/figures/openstack-arch-havana-logical-v1.jpg)

BTW this image is taken from the OpenStack "Getting Started" section.

My response: Well, shit. Guess I've dealt with worse. I hope there isn't magic happening. I'll trust the Fuel installers.

## It Is Fragile

Refer to the previous diagram. With so many moving parts and given the lack of talent capable of managing it there is a serious level of risk in trusting a critical production environment on this.


My response: Keep my public cloud fail overs built and ready to deploy. I'm a cheat.

## It Is Vendor Driven

I kinda knew that the growth of OpenStack was tainted by vendor intrigue. I have run into this spending a considerable amount of time working with OAuth 2.0 when the "framework" was going through proprosals and the lead writers were walking off.

Cite: [OpenStack is Doomed - Andy (termie) Smith](https://www.openstack.org/summit/vancouver-2015/summit-videos/presentation/openstack-is-doomed-and-it-is-your-fault)


My response: Ick

# The Final Decision

While it might work for a team like RackSpace, I don't think it fits what we need. The cost benefit of having a few drivers and some prebuilt scripts to managing images wasn't enough to justify the cost and risk of having a system that is so fragile.

The risk and the knowns of unknowns inside the massive spaghetti of scope creep was enough that I couldn't justify that I wouldn't be able to jump in and fix something within less than a day. Pretty much every code fix I had to make took more than a day. More of 3-5 days to figure out each bug.

## OpenNebula

We tried other stacks and I launched a multiple node infrastructure with OpenNebula. It was refreshingly vertical and self-contained. But still felt like it wanted to follow the hypervisor slipstream of OpenStack.

## Blah-Stack

There was a lot of other options but I was burned out at this point.


# Conclusion

- There is no free ride. (Development is an Expect to Work Employment)
- Swiss army knives suck for self-defense and bayonets
- Don't expect to launch a cloud out of the box that will fit your business needs
- If you believe the marketing - baaah
- Community first, politics last
