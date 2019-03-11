---
date: 2016-02-24T23:20:36-08:00
title: Dump Django Databases and Create Fixtures for Testing
tags: [ django ]
image: images/django_pony.jpg
comments: true
---

## Fixtures are a Messy Mess

It is quite a pain to maintain fixtures it seems. I am not sure why yet. Maybe there hasn't been quite enough time on this piece of the product for it to mature.

## Django dumpdata

I tried several different variations to dump the data. I'll include a few of them here since they might actually work for someone else.

  python manage.py dumpdata > fixture.json

I kept getting various key errors.

  Could not load contenttypes.ContentType(pk=23): duplicate key value violates unique constraint "django_content_type_app_label_76bd3d3b_uniq"
  DETAIL:  Key (app_label, model)=(businesses, business) already exists.

Eventually turned into this:

  python manage.py dumpdata --indent=4 -e contenttypes -e auth.Permission -e admin --natural-foreign > fixture.json

OR

  python manage.py dumpdata --natural-foreign --natural-primary --indent=4 > fixture.json

gave me this:

  Could not load object.User(pk=None): null value in column "user_ptr_id" violates not-null constraint

## DumpData Alternatives

The [django grid](https://www.djangopackages.com/grids/g/fixtures/) to the rescue again.

A lot of the packages were for generating testing fixtures. I don't need that. What I need is basically a data backup tool so that whichever dev has the best copy of the data to be able to create the deployment fixture.

I decided to give [Fixture Magic](https://github.com/davedash/django-fixture-magic) a try.

### Fixture Magic

My initial test wasn't very promising.

  ImportError: cannot import name loading

But apparently I wasn't the [only one.](https://github.com/davedash/django-fixture-magic/issues/37)

  -e git://github.com/davedash/django-fixture-magic@42c6df73d11512d76e3170453f175164ff22db02#egg=django_fixture_magic

Then I found out that I can't have non-int keys. Since most of my objects use UUID that was the end of F-Magic.

## I Gave Up On Fixtures

This data model must just be too complex.

Deploying dev environment now consists of setting up the db and loading a full DB dump.

  pg_dump APP > APP/fixtures/pg_dump.latest.sql

Load it up with a script when deploying dev.

  psql APP < APP/fixtures/pg_dump.latest.sql

## How Now Tests?

I know. Fixtures are kinda important with tests. I went ahead and installed [Factory boy](https://github.com/rbarrois/factory_boy).

Good enough for now.

Sorry Django Fixtures. You kinda suck.
