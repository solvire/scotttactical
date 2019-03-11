---
date: 2015-12-01T10:43:58-08:00
title: Try Not 2 Fuck Up Ur Engineering
url: /try-not-2-fuck-up-ur-engineering/
tags: [ software, leadership ]
comments: true
---
Leadership Checklist for Non-Technical Managers

How do you build software that provides value to both clients, owners and engineers?

This list has started as a list of notes that I kept over the last few years. Yes, this is the abbreviated version of [Management For Quality Software](/management-for-quality-software-development/).

## Executive Leadership

*   Bloated and ugly products are born at the top, but a good engineering environment may begin there
*   The three ways business leaders can add value is with _numbers, numbers, numbers_
*   Put your name on the product

### The Business Requirement

Write a business requirement that reflects specific details about a problem that the business is solving based on market research numbers. A full description is beyond this terse scope.

### Feature Requests R Bad

I know you really want to. You think you know UI design and are well versed in using a browser. In reality you probably suck at engineering/UI/art.

See previous paragraph sentence 1.

### Feature-Driven Cycles Suck

"When is the report download page going to be done?"

Not by the definition in agile dictionaries, but defined as the environment by which business determines short term goals in reference to features.

### Business Vision

*   Set a clear vision
*   Make the vision both short and long term
*   Don't pivot
*   Avoid buzzword glory pitchmen

### Employee Goals

*   Consider the employees goals in your vision
*   If you do not care about the employees' goals then they might set their own
*   Have an idea of what motivates people (We are not all building rockets or curing cancer)
*   Make an employee goal the production of a quality product

## Optimal Relationships

A few items here that I look for:

*   Does the team easily share code
*   Do they internally set group functions (meetings/lunches/after-hours) – can be dangerous
*   Can they tell you what others are working on
*   Are there a lot of complaints about coworkers
*   Ask them who the best employees are
*   Provide a way to communicate problems to leadership

Devs need [CS 666 Political Science](https://michaelochurch.wordpress.com/2014/12/) training. Seriously.

## Hire the Right People

![Milton Office Space](/images/milton.jpg)

Hire people smarter than you and get out of their way.

See my other articles on [hiring technology professionals](/interview-strategies-a-technology-hiring-manager/).

### Don't Micromanage

Nuff said else failed previous item.

## Understand Software Shelf Life

### Shelf Life Definition

Software expiration has passed when both of the following criteria have been met:

*   It no longer produces enough value to support the maintenance of the code
*   The proposed value from software improvements is less than the cost of the improvements

### Predict The Futures

Applying a timeline to the life of an application is hard. Not because one cannot estimate a project life, but because most are not truthful with themselves on the potential of their project.

Ass.u.mption: shoestring ultra-successful software lasts forever and will fix rare bugs later when money is pouring.

### Yeah – Fix It Later

Don't fail the "fix it later" mentality. Sometimes disposable software is appropriate. If you only need to scrape a website once then just write a quick and dirty script and then archive it.

### Plan For The Futures

We don't really know what the future holds for us, but we should plan for it. Ask this:

* Where is this script stored and why?
* Where is the documentation?

If it is only stored locally and undocumented on someone's machine: fail++.

## Bad Code Costs Moar

*   There is no fix-it-later scenario.
*   There will be no point where you be chillin' counting benjamins letting engineers scrub code
*   There is no pattern that fixes an anti-pattern
*   There is no way to pause the businesses for your migration

You can only pick 2:

![Good Fast Cheap - Pick 2 - Venn Diagram](/images/good-fast-cheap-venn-diagram.jpg)

### What is Bad Code

This is a hard one to explain.

*   Sometimes biz pushes devs to deliver sooner than estimates, so they cut corners.
*   Sometimes coders are lazy or do not really want to be on a project business is pushing them to move faster on.
*   Sometimes coders are just not any good. You hired them so now it is a containment issue.
*   Have peer reviews and pull requests, and yes, that costs. See: *Outsourced cheap stuff*

### Myth of the Parallel Rewrite

Scenario:

*  Going to refactor legacy code
*  Also continuing development or maintaining the current code base
*  Not contributing more human or financial resources
*  Done in 1/10th the time that the original code base was developed
*  Macho Camacho for President!

<iframe width="560" height="315" src="https://www.youtube.com/embed/sGUNPMPrxvA" frameborder="0" allowfullscreen></iframe>

## Software Development Lifecycle

A reasonable software lifecycle is imperative to delivering quality software.

No cycle == Bad mkay

### Politics of The Lifecycle

I intend to write at more length about the politics behind the product lifecycle.

Case study: There is no policy for a daily deployment to Curiosity rover on Mars and if the previous glitches are an indicator we can assume that even [NASA has a high bug rate](http://www.space.com/23553-mars-rover-curiosity-software-glitch.html) when dealing with rapid product deployments.

## Test - For the Love of All That is Sacred, Test

*  If you do not have tests your software probably sucks
*  Tests indemnify engineers and build confidence
*  Broad set of tests == enjoy the weekend == morale
*  New features probably will not break existing functionality
*  If there are no tests then deployments are a crap shoot
*  Wide Coverage Is Safety
*  Estimate tests writing time
*  Know your tests
*  Damn the tests - DO IT LIVE!

Imagine this conversation:

Biz Guy - "The super widget functionality I had you put in there last month is not working. What did you guys break?"

Programmer - "All tests are passing. I am looking and there are no tests covering any business requirements for such a feature. If you want we can take a look and write a test that covers this feature."

## Conclusion

Build things that make the world better. Treat employees like people. Give back.
