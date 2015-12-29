---
date: 2015-12-01T09:53:52-08:00
title: Management for Quality Software Development Managers
url: /management-for-quality-software-development/
tags: [ leadership ]
image: images/management-text.jpg
comments: true
---

This started as a list of notes for my boss on how I see the best way to manage technical professionals. I am trying to provide non-technical managers with the resources to direct technical teams in a way that will produce quality software and keep the engineering staff engaged and moving.  

How do you build software that provides value to both clients, users, owners and engineers for the years to come?

This also assumes a state of:

*  Knowing how to hire
*  Having some resources - not 8 figure funding but enough to pay market rate
*  Having a legitimate business model - I suppose it would work for a pr0n spammer too though
*  Embracing a genuine desire for quality, progress, and community

# TL;DR:

This document contains > 2k words.

See the terse version:

[Try Not 2 Fuck Up Ur Engineering](/try-not-2-fuck-up-ur-engineering/)

# Software Shelf Life

All software has a shelf life. Some software must last for a very long time whereas some software is disposable. Software longevity is derived by the leadership from the top of the organization and if software applications pass their usefulness it is due to the guidance of the leadership. It should not be assumed that long lasting software is the “best” type of software for every need and I will briefly attempt to give some very high level tools I use to determine the case by a set of criteria.

    We have achieved infinite software longevity!!! - NOT

![We Have Infinite Longevity! - not](/images/mcd.gif)

## Shelf Life Definition

[Nasa is looking for](http://www.popularmechanics.com/space/a17991/voyager-1-voyager-2-retiring-engineer/) [Fortran](https://en.wikipedia.org/wiki/Fortran) engineers to interact with the Voyager space probe. This is one of those exceedingly rare cases when the software outlasts the engineers. Also, I will throw up if anyone throws out the obligatory trope: “they do not build 'um like they used to”.

I like to define shelf life in the following way. Software expiration has passed when both of the following criteria have been met.

*   It no longer produces enough value to support the maintenance of the code
*   The proposed value from software improvements is less than the cost of the improvements

Intelligent managers can determine the above criteria by the numbers and without much confusion. Businesses who are in a state of going out of business will come upon these decision by running out of resources and will be forced to shut down projects or archive code.

It should be noted that time is a very important factor to consider in the calculations. It might be affordable financially to have cheap labor work on fixing code for extended months or years, but sometimes opportunity loss has to be calculated. Throwing resources at bad decisions is a recipe for losing. This is a relative of the sunk-cost fallacy.

## Predict The Future

This is a bit of art, but applying a timeline to the life of an application is hard. Not because one cannot estimate a project life, but because most managers are not truthful with themselves on the potential of their project. They assume that they can shoestring ultra-successful software that will last forever and if by some rare event bugs show up, well, they can be fixed later when the money is pouring in.

The “fix it later” mentality is the most common error I encounter. Considering that the majority of my career has been spent cleaning up bad decisions I am qualified to attest to this. Normally when in the “fix it” stage, business principles have lost their original love of the project and are looking for something else to work on. They are probably planning their exit strategy or engaging a new mistress.

It is not reasonable to say that a project is going to be highly successful and at the same time treating the project like it will only last 6 months. What I mean by this is the software lifespan is implied at six months or less if the management implements development principles that guarantee short-lived software.

Sometimes disposable software is appropriate. If you only need to scrape a website once then just write a quick and dirty script and then archive it. It is worth noting here that having an intuitive and organized archiving procedure for scripts will add a lot of value by turning a code trash pile into a tool chest.

## Plan For The Future

We do not really know what the future holds for us, but we should plan for it. One main reason we know about the champion societies of the past and can learn from them is they planned for future peoples to read their story. Monks and librarians have toiled meticulously in the storage and organization of these. This is in contrast to those “barbarian” societies that languish far behind and suffer the problems of a chaotic and backward people.

A manager can simply ask “where is this script stored and why?”. If it is only stored locally on someone's machine: fail++. The answer to this will show if the coder cares about anything past the initial writing of the script. If there is documentation on the scripts linked from the organized repository then win. Generally that level of control can only come from an experienced technology leader.

I cannot quantify precisely but disorganized file storage and a lack of repository protocols accounts for a large portion of “code sin” and will absolutely contribute to the weak ROI in the future. It is a truism to say that most of the coding problems have been solved before and that at this point the coders are just building slightly on top of those before them.

# Bad Code Costs More

Please see the below diagram. You can have any two of the following scenarios.

![Good Fast Cheap - Pick 2 - Venn Diagram](/images/good-fast-cheap-venn-diagram.jpg)

-  There is no fix-it-later scenario.
-  There is no point where you are just chillin' counting yo monies while letting engineers clean code sin
-  There is no pattern that fixes an anti-pattern
-  There is no way to pause the businesses for your migration

## What is Bad Code

This is a hard one to explain. Many things can contribute to bad code.

![Milton Office Space](/images/milton.jpg)

### The “why” of bad code.

Sometimes it is because a requirement is placed on the engineering team that pushes them to deliver something sooner than their estimations. Programmers are generally a timid and self-disparaging lot so they tend to over promise. They are afraid to tell business that things cannot be accomplished so they cut corners. All those combined is a recipe for faults and bugs.

Sometimes coders are lazy. You can spot those too. They do not really want to be coding or they do not like the job they are doing. On top of that business is probably pushing for them to move faster. What is the motivation not to stuff the sin under the rug.

Sometimes coders are just not any good. You hired them so now it is a management issue and the only way to keep bad code from getting into the repository is to have peer reviews and pull requests. That takes quite a bit of time so again you have not saved any money with your outsourced cheap stuff.

I will go into this topic in more detail in another article.

## Myth of the Parallel Rewrite

It has been a common theme in my career to hear business folks tell us that they are going to refactor code while at the same time continuing development or maintaining the current code base while also not contributing more human or financial resources to the equation. And all of this will be done in 1/10th the time that the original code base was developed.

To paraphrase Presidente Macho Camacho's State of the Union:

<iframe width="560" height="315" src="https://www.youtube.com/embed/sGUNPMPrxvA" frameborder="0" allowfullscreen></iframe>

# Software Development Lifecycle

A reasonable software lifecycle is imperative to delivering quality software. The terms of the lifecycle are entirely determined by the needs of the business, but doing away with an organized lifecycle is a recipe for failure. Maybe a business needs to fail to encourage the evolutionary aspect of the free market. Failure is not so beneficial though if no one learns from the mistake.

{{< figure src="/images/git-model.png" title="Git Model via Vincent Driessen" link="http://nvie.com/posts/a-successful-git-branching-model/" >}}


## Politics of The Lifecycle

I intend to write at more length about the politics behind the product lifecycle. At this time I will just leave the note that the deployment schedule reflects software critical value. Requesting a development team to constantly deploy denotes a lack of care regarding software quality and stability. There is no policy for a daily deployment to Curiosity rover on Mars and if the previous glitches are an indicator we can assume that even [NASA has a high bug rate](http://www.space.com/23553-mars-rover-curiosity-software-glitch.html) when dealing with rapid product deployments. Critical software needs a settling time.

# Optimal Relationships

What is a development team without a solid lesson in [CS 666](https://michaelochurch.wordpress.com/2014/12/). In such a petty manner, decent engineers will offset very good engineers to find their ways into the Herman/Miller of power. And given what we already know about politics + geekness; it is easy to see that the worst of a Klingon Game of Thrones will play out.

It is imperative for leaders to set managers in place who will put the team first instead of their careers. That kind of leadership rarely exists outside of sports and the military hence why I am well versed in tribal coalescence.

How can you spot a problem? It is beyond the scope of this article to provide a team-building dissertation but I will append a few items here that I look for.

*   Does the team easily share code
*   Do they internally set group functions (meetings/lunches/after-hours) – can also be dangerous
*   Can they tell you what others are working on
*   Are there a lot of complaints about coworkers
*   Ask them who the best employees are
*   Are there provisional methods for communicating concerns up the chain of command

# Executive Leadership

Bloated and ugly products start at the top and only the resources for good engineering begin there.

![Steve Jobs](/images/jobs.jpg)

Even Steve Jobs got booted.

If the leadership is only concerned with making quick cash then the product quality is probably going to be garbage. If they are only in it for the money why would they care about the product. If they are in it for ego then the product will probably look like a cartoon.

Personally I love making things and my personal image comes with the work I do. From building cars to writing quality code, I try to create things that are valuable and last beyond my time.

Good leaders should just plant the idea, find the people that want to complete it and stand out of the way and watch the numbers. Sorry chief, if you want to be creative you gotta give up the title and join us heroes in the trenches. The three ways business leaders can add value is with numbers, numbers, numbers.

## The Business Requirement

Write a business requirement that reflects specific details about a problem that the business is solving based on market research numbers. The problem must be defined with clear terms and with enough details so that anyone who is not familiar with the product can figure out how they are benefitting from the change. The product managers should be used to simply translating business requirements only so much as that they make sense to everyone involved. Engineers should be able to express the problem back to stakeholders in terms that the customer can understand.

## Feature Requests R Bad

I know you really want to. You think you know UI design and are well versed in using a browser. In reality you probably suck at engineering/UI/art though. If you are looking at a widget on another site and trying to “innovate” a feature into your product but lack any sort of market research data for that specific functionality then you can count yourself among most managers. It will probably dictate poor code and make employees short sighted and unhappy. Good luck hoss.

See previous paragraph sentence #1.

## Feature-Driven Cycles Suck

“When is the report download page going to be done?”

Not by the definition in wiki, but defined as the environment by which business determines short term goals in reference to features. Referencing a small block of public-facing functionality without any understanding of the iceberg underneath it does no service to the longevity of the code or the team and shows a lack of technical savvy. Savvy?

While the most common form of product life cycles in my experience I find it to be the least beneficial to morale and code quality. Of course every place I have worked has been “agile” really it was just agile in name and then when business wanted something they shoved a feature request at us asking for a button that does X or a report than shows better numbers on an always increasing trend.

## Business Vision

![Clockwork Orange](/images/clockwork-orange.jpg)


- Set a clear vision.
- Make the vision both short and long term.
- Do not pivot.

If you say that the market has shown people moving toward X so you are going to help the company get there then actually do that. And if six months down the road you pivot and say that product Y is the new focus and that the previous work towards X is halted: well, then you loose leader cred. The market does not change every 6 months. You probably just listened to a pitch guy smooch his way onto your planning team and shine up the buzzword array of glory.

## Employee Goals

Consider the employees goals in your vision. If you do not care about the employees' goals then they might be setting their own underneath you. We are not all building rockets or curing cancer. Have an idea of what motivates people. When you know your employees then you know how to help them. I tend to define the distinction between leaders and managers as those who take responsibility for those they lead vs those who who only care about pleasing their managers.

Make an employee goal the production of a quality product. Even if someone is not building rockets they can still have pride in something. If they are building crap however no one wants to tell their family about it.

# Hire the Right People

    Hire people smarter than you and get out of their way. - Multiple References

I have written a little bit on the aspects of hiring technology employees. This is extremely important. You have not studied and worked 20 years in the engineering field so there is no way to teach you how to think like us. That is a separate skill. Just because you can drive your car and change the oil does not mean you can engineer a better motor.

# Test - For the Love of All That is Sacred, Test

If you do not have tests your software probably sucks. Or maybe it just works fine and you do not realize that it sucks. Either way it is a nightmare.

## Tests Indemnify Engineers

Engineers who have a broad and covering set of tests can enjoy the weekend knowing that new features probably will not break existing functionality.  

On the other hand, after every release the business managers will suspect any drop in traffic or margin to be associated to some change made by the engineering team. If there are no test cases covering anything then it is likely the engineers did break something.  

## Wide Coverage Is Safety

Have enough coverage so that coverage is a business requirement.  If there is no coverage at all on a 2 year old application then there is not much case for starting to create tests.  You probably should not be working there anyway, unless you have upside.  If however, most of the application is covered in a test then adding functionality without tests because businesses moved deadlines up sets onus back onto business for allocating resources for test writing.  

Imagine this conversation:

Biz Guy - "The super widget functionality I had you put in there last month is not working. What did you guys break?"

Programmer - "All tests are passing. I am looking and there are no tests covering any business requirements for such a feature. If you want we can take a look and write a test that covers this feature."

## Know Your Tests

Business should know as much about tests as "features". Granted if the user base does not care about quality then tests do not matter much.

# Conclusion

Go forth and create good things.
Then give back to the world.
