---
date: 2017-04-26T17:54:56-07:00
draft: true
title: What is Link Unfurling
url: what-is-link-unfurling
tags: [ technology ]
---

# How do I Those Rich Effects On My Website

I posted a [link to Slack](https://api.slack.com/docs/message-link-unfurling) once and it loaded up all this cool information.  I couldn't figure out what was going on but was sure that it just ripped a ton of stuff out of the HTML headers. The METADATA.  

If you are a relative novice you might not know about all that junk-in-the-trunk that is stuffed into the HTML. It's pretty bloated. And getting more so.

I found this to be a very helpful source of [information about unfurl](https://medium.com/slack-developer-blog/everything-you-ever-wanted-to-know-about-unfurling-but-were-afraid-to-ask-or-how-to-make-your-e64b4bb9254).

I didn't plan to show many pictures related to unfurl but for an example here are some below.


The first is a nice response from revzilla showing some products and their prices and how they ranked in the reviews.

![Revzilla Unfurl](/images/unfurl1.jpg)

This one is from a joomla powered property site. Not bad but not helpful. A picture would have been nice. Wordpress probably takes care of most of this. For the lazy ones out there.

![Joomla Unfurl](/images/unfurl2.jpg)

The last is of course the link above with plenty to get you going.

![Medium Unfurl](/images/unfurl3.jpg)

# METADATA and Unfurl

The leaders on this topic are Twitter and Facebook.

METADATA is essentially data about the data.  It's data about the data that is on your rendered page. Something useful so that apps and web crawlers can make easy work of reading your content and consuming it.

Basically you are making Google Twitter and Facebook's job easier for them. No they wont pay you. Yes they will make money off your data. No you can't do anything about it. Worship your new WalmartStarbucksMopoly Overlords.


Below are some of the fields that they look for.

## Facebook OpenGraph

https://developers.facebook.com/docs/sharing/webmasters#markup

```html
<meta property="og:url"          content="http://www.....nk-alike.html" />
<meta property="og:type"         content="article" />
<meta property="og:title"        content="When Great Minds Don’t Think Alike" />
<meta property="og:description"  content="How much does culture influence thinking?" />
<meta property="og:image"        content="http://stat....bo-v2.jpg" />
```


- **og:url** – This will be the URL that will be associated with your content ie the link.
- **og:type** – The type of content. Think of these as categories, hotel, blog, article etc. See types: https://developers.facebook.com/docs/reference/opengraph#object-type
- **og:title** – The title of your page, content, object etc. as you would like for it to appear when displayed on Facebook.
- **og:description** – Perhaps the most important tag. This is the 1-2 sentence snippet that shows up in the post. Write this carefully as this can be the difference between getting clicks or not.
- **og:image** – The URL for an image you want to represent the your content. Images must be either PNG, JPEG and GIF formats and at least 50px by 50px.


If you have the above metadata elements in your page give FB crawler a try and see what it looks like.

    https://developers.facebook.com/tools/debug/

## Twitter Cards

Twitter is also another innovator in this field. They offer rich experience cards for posting onto twitter. This is a good way to have a nice presentation of your data if people so happen to share. Twitter needs a lot of rich context because it's just a stream of nonsense most of the time.

Here is a list of the twitter card tags: https://dev.twitter.com/cards/markup


#
