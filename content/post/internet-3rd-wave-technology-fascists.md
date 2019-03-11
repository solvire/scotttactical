---
date: 2016-12-04T13:13:26-08:00
draft: false
title: Internet 3rd Wave and Rise of the Technology Fascist
tags: [ technology, politics ]
---

## The Waves of Technology Professional

I like to consider 2001 the tail edge of the Internet bubble.  It was a brutal time to be in a computer science field. There weren't many jobs. The jobs that were being squatted on were jealously guarded. I needed the one thing that nobody would provide. Experience. So instead I grinded projects and studied unceasingly.

In 2001 I had to take a job as an "integration specialist".  That is basically a programmer job with a crappy title, so they didn't have to pay me much. I was making $12.50/hr, and it was business casual dress code.  Meaning I worked for barely enough to pay my bills, but I had to wear a tie to work. This Internet revolution was starting to look like a failed promise. I should have realized then.

The point of this writing is not to sound weepy or nostalgic. It is to point out the direction of this trade and to try to illuminate the evil of being efficient only for the sake of being efficient.

## The 1st Technology Wave

My father is a software engineer approaching retirement. He programmed midrange and mainframes, so I was exposed to this stuff my whole life. Ironically I loathed computers and vowed to go into the military where money and schooling wouldn't matter, but that's another story.  

In the pre-boom days, there were a lot of people coming up with ways to make things happen.  People were building web servers and writing routines to return data in formats that web browsers could read. My roommate in the Army was a very rare computer science major and helped me start building Linux boxes in my bedroom in 1998.

The first technologists in this field were doing their best to get computer hardware to do new things. A narrow field of technology started to form around TCP/IP and HTTP. We were creating a boom culture.  

## 1st Wave Engineers

The guys working on internet technologies before 1995 were completely different than the ones nowadays. These were engineers in the old sense. They wore suits to the office. They had a 9-6 job usually.  They were seen in a similar manner as industrial engineers, electrical engineers, chemists, or mathematicians.  

These guys seemed to be relatively conservative with their approach. They didn't have a lot to go on and sorta made things work.  There wasn't much focus on design or art at all. It was purely pragmatic.  Bits in and bits out.

Imagine a problem today. You don't have Google. You have a 1,000-page document on your operating system. Now figure out how to get your server to print to a dot matrix printer over serial.


## DotCom Boom

The people I initially started working with were a mix of self-taught programmers and people who were left over from the big machine era. The field was getting flooded with engineering speculators. The idea of moving to California and striking it rich with technology was too hard to resist so I foolishly was caught up into the surge. I packed up and moved to Simi Valley with a former military buddy of mine as we set out to gain our fortunes.  Boy, was I in for a surprise.


## Stepping Over Opportunities

I was offered a few opportunities that were less than ethical. Some porn, some spam, some malware. I turned them all down, because I was here to help change the world for the better. I wanted to work with a big organization that did great things. That never manifested and I realized that there isn't any great company helping the world. They all have an uber-powerful dark side that powers their facade.  The CMO is the bishop of this church.

## The Clickpocalypse

By 2005 I found myself working for a company that was running an offer path. Basically one of those sites where you enter your email and get a free iPod. It made an obscene amount of money. It was super dirty too.  Myself and a couple other engineers stood up a site in 3 months and starting bringing on hundreds of thousands of new users a day.  It was pouring in money. There were all sorts of Italian sports cars in the parking lot.  People were partying hard.  Except the nerds. We were locked into the office while they flew all over the world having fun.

Our biggest target was middle and later aged people who were at home with nothing better to do. Majority women. I think 60% was a number I saw a lot.  It exploited a demographic incredibly well.  From time to time I thought that there couldn't possibly be this many suckers out there.  Could there be an unlimited supply? Apparently so.  

We ran on cheap commodity hardware and buily our own rack in a data center. We didn't have anyone helping us out. The coders were as likely to be going down and compiling at the data center as anyone. We handled as much traffic back then as any company I have worked at since then.  

We spread our data out wide. We were doing things that didn't have names yet. We were buffering with local disks and clustering on shared storage. We were aggregating streams of log files. It was quite the learning experience.  

## Engineering Conservatism

Back in this period, there was still a mentality of being conservative with our decisions.  The cutting edge was generally considered suicide.  Not that it was unstable, but that you are betting your reputation and career on that gamble.  If your very basic business problem could be solved with mature technologies then that is what you used.  These days failure is grounds for a promotion and telling your boss you plan to do something cool is actually as good as doing what the business needs.

We used a kernel from BSD or RedHat that had been vetted in the field for multiple years.  We stripped layers of unknown from the presentation languages. Most of the code was in Perl and PHP and we compiled those ourselves.  It was incredibly lightweight. Because we built the OS stack, we were able to fine-tune to squeeze everything out of the boxes.  People were coding in production and deploying nonstop. It was a flying chaos.

With a stack of 7-8 web servers with between 1/2 and 2GB of RAM, we were able to handle more traffic than many Grande sized deployments on AWS.

## Gluten Free Buzzwords

I didn't start getting swept up into the buzzword mania until after 2010. It began to seem that if I wasn't using some new technology thing that I was irrelevant. I started consuming new technologies like crazy.

Buzzword technology replaced computer science discipline. Before 2010 I spent time learning basics of architecture and design patterns. After 2010 I spent all my time plugging in some nebulous new appliance into my bloated and overweight stack.  Before 2010 I was learning how memory allocation and database calculations work. After 2010 I was trying to figure out how to grow my instances inside the AWS monolith.

It seemed as though every software geek was intoxicated with the pace of change.  Their value was in the number of technologies they touched. This silicon zealotry was almost like the mob movements seen in nationalism or tribalism.  Giant herds of people storming the gates.

## The 3rd Wave

### AWS:GITHUB Winning

AWS won. They removed the cost of entry for people to get a server up and going and allowed for a new breed of engineers to enter. One of the biggest costs to getting large sites up and hosted was learning how to build and deploy hardware and networking, and then fine tune it. Amazon capitalized on this need for speed. It wasn't about getting a stable product to market faster: it was the sales pitch of being able to use a bunch of buzzwords and then show a prototype to investors very quickly. Amazon knew that this is how it would go.

### Constant Deployment

This is an especially important mindset of 3rd wavers: they have a very low sociopolitical self-worth. What I mean by this is there is a massive race to the floor when it comes to their control over what they deliver to business and stakeholders.  They have embraced the "fail fast" mentality and reduced the quality of their trade.   The deployment lifecycle might be the most valuable tool in maintaining power at the engineering and systems level.  


Let's take two scenarios. One person is an engineer for an avionics company. The other for a social media company.

These avionics engineers probably work fewer hours and have better perks. They are probably not bullied by sales and product management and also have insight into how the company grows.  They are very concerned about quality control principles and advanced engineering disciplines. Their average age is 48 and are mixed with Baby Boomers, X'ers and a few Millennials.  They  support multi-billion dollar contracts.

The devs working on the social media product were probably contracted from BFE for $25/hr and will be dumped as soon as the project is over. They work insane hours and are constantly berated by their management, sales and teammates. Their average age is 28 and are part of the Millennial caste. So, basically every place I have worked since 2009.  

Business would listen to us if we worked together. There is plenty of money there for us to carve out a stable future.  

### Bugpocalypse

Is this rapid progress good? I would say software is no more stable than it was before. Statistics do not allude to fewer bugs. In fact, in the near future, we could be looking at a major problem with zero-day vulnerabilities, IoT, the Java monoculture, and the flood of inferior engineering skills in the last 8 years.  

Internet tech is following a similar "population explosion" path that exists in biology.  

## Technofacist

The Internet applications industry seems to be taking the exact same route that terrestrial radio and cable television took. They had huge explosion of small companies and then an all-consuming consolidation into a few major players followed by governmental and special interest group integration. My assumption is that it will be 3 for us: Google, Facebook, Amazon.

The 3 horsemen are poised to dominate everything online.  You might think this is totally fine with the whole economy of scale nonsense, but you might also want to look at history.  Powerful systems usually will move fast to crush competition and control their constituents.  This consolidation of power is facilitated by the unquestioning loyalty to the system.  Because the system gives us one-click purchases and the ability to see our friends' cat habits any time of the day we are okay with letting them brand us and feed us garbage. They are turning the Internet into Walmart and Costco.

The new generation of engineers have very limited understanding of the things that it takes to keep all this equipment going. Within a few years, there will be very few people left that understand the entire stack.  The systems administrators are the first to sell off their souls to Amazon which is tantamount to sawing off the tree branch you are standing on. Once Amazon provides enough buttons, then all we need to do is move the jobs overseas.   

More than once I have heard a DevOps engineer tell management that their goal is to code away their job.  Please, tech people! Stop sucking at politics and curb your enthusiasm.  

Soon it will be powered mostly by offshore companies, weakly skilled coders stabbing at each other over scraps and the very few good engineers working inside giant monolithic companies, mired under lack of progress and nonstop political infighting. Maybe I should just focus on getting a job at one of those places, or go back and get an MBA and push around technies.

## Conclusion

It is probably too late to reverse the trend. It is disappointing to see the greatest communication medium ever developed, turned over to a handful of massive corporations.

Make Internet Grate Again
