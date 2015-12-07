---
title: PHP Hypermedia REST API wrapper
author: solvire
date: 2015-09-08
url: /php-hypermedia-rest-api-wrapper/
tags: [ php, hypermedia, api, laravel ]
image: images/laravel-5.png
comments: true
---
## Hypermedia for PHP APIs.

Well, here it is.  I'm finally finishing up my Hypermedia layer for our [Laravel 5.1](http://laravel.com/docs/5.1 "Laravel 5.1") build. I am excited about the possibilities for this library and think this might help bring more PHP products into the era of [Internet-of-Things](https://twitter.com/hashtag/iot) (IoT).


### In Production - Alpha

Right now I have it in our very alpha phase version of the software running the [LeadFerret](http://docs.leadferretuser.apiary.io/#) business lead search system.


The project is on github here: [PHP Hypermedia API Layer for HATEOAS HTTP or REST Services](https://github.com/solvire/php-hypermedia-api)

It is slowly getting to where I would like it to be. Of course it takes a lot of work to manage business expectations since they and PHP devs tend to treat an API like a junk drawer.

### So why now?

For about 20 or so years we have been collectively building sophisticated network interfaces for humans. The most advanced interface is the web browser. The browser's job is to present or render data to the user in way that allows them to consume and then determine what the information means. In addition to the specific data quested the server will also present the representative data that delivers context. This was necessary by convention and dictated by market demand. People en mass were going into the business of supplying customers and other businesses with data. For the most part that data is self-serve. I'll write more about that philosophy at a later time.


## Metadata and Context

Each response should contain everything that is necessary for an intelligent agent to decide what to do next. Considering that machines will eclipse humans in pretty much every intelligence metric we can be qualified in keeping them in the category of intelligent agents. They will be making their own decisions based on the data.


In the past the design of an API would leave the interpretation of the HTTP service up to the designer of the API's consumer. The context of the data is completely absent from the source of the data. Most of the time the designer of the client would have to build a specific set of functions or classes that would represent what the designer believed the documentation was trying to tell us about the data. Most web service designers were so far off from matching the returned data streams with the actual business objects the data represented that there was no great benefit in trying to have a client that mimicked the server object structure. The simple genius of the REST paradigm is that is requires the business object to be represented in the transaction and builds on the strengths of HTTP.

## Data Context and the Long Form


Sample JSON output with context

```JSON

{
    "currentItemCount": 1,
    "items": [
        {
            "company": {
                "address": "4209 Technology Drive",
                "alexa": 0,
                "area_code": 510,
                "city": "Fremont",
                "county": "Alameda",
                "domain": "3pardata.com",
                "employees": 15,
                "f1000": 0,
                "fbpage": "",
                "id": 38252,
                "location": {
                    "latitude": 37.520000457764,
                    "longitude": -121.95999908447
                },
                "naics": 0,
                "name": "3PARdata, Inc.",
                "phone": "510-413-5999",
                "revenue": 35,
                "sic": "3572",
                "state": "CA",
                "year_founded": 1999,
                "zip": "94538"
            },
            "created": {
                "date": "2015-09-30 06:06:55.000000",
                "timezone": "UTC",
                "timezone_type": 3
            },
            "crowd_score": 0,
            "first_name": "Jeff",
            "gender": "male",
            "id": 12756,
            "last_name": "Price",
            "phone": "510-413-5999",
            "professional_categories": [
                "engineering",
                "photographer"
            ],
            "score": 38,
            "title": "Vice President of Engineering and Founder",
            "title_level": "VP",
            "useragent": "Chrome"
        }
    ],
    "itemsPerPage": "50",
    "pageIndex": 1,
    "totalItems": 1,
    "totalPages": 1
}
```

An allegory: an API client contacts a web service requesting a list of book titles. The most economical thing would be to stream back a delimited list of integers. That was all that was requested right? Could anyone figure out what it means if found alone. Not really. Only if they were able to consult with other sources: namely the documentation.

Social and modern media tends to deliver everything in the short form. It only provides the least amount of information possible. And then by a genetic algorithm the data that is the most entertaining bubbles up to the top. It lives without context. A picture of a cat or a meme with only a few lines. Even important topics in politics and commerce are made without context. The long form is dead. Although I have started to see a renewed interest especially when visiting Medium.

## Architecture

This SDK attempts to represent a paradigm that mimics the organic agents of the Internet. Sorta. What I mean by that is the naming convention and the architecture are set up so they suggest some structures that are self-documenting. For instance the main controller for the pattern is a RepresentationalController. It represents the resource. If there is something that needs to be presented pertaining to the resource the RepresentationalController should answer the call.

Because the RepresentationalController is going to interpret the call it must handle translation of the verbs. Thankfully there are only a handful of authorized verbs so the interpretation is trivial.

I will elaborate more on the individual aspects of the architecture at a later time. Right now I'm leaving it brief.

## Closing

Probably not an acceptable instruction, but it's a start. I'll keep posting as I can.

ST
