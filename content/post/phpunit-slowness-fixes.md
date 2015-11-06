---
date: 2015-11-04T12:57:42-08:00
title: PHPunit Slowness Performance Suggestions
url: performance-suggestions-phpunit-slowness
tags: [ php, testing, performance, software ]
---

# PHPUnit Is Slowness 

I love [PHPUnit](https://phpunit.de/) don't get me wrong. More than a testing library, I like testing, or having tests. It's like the code got yo back bro! Build code that lasts.

_EDIT_: I know most of the problems are inherent with tests not the testing framework.  However, my requirements dictate how I use it to a certain extent.  Peace. 

## PHPUnit is painfully slow. 

![PHPUnit Is Slow](/images/turtle-speed.jpg)

Seriously. Though. Maybe having a concurrent environment it can run it would help. I worked at a place with 65,000 unit tests and if they ran as slow as our unit tests here it would never finish. It was literally taking 30-60 seconds per test. That is 65000 x 60 = 1083 hours or 45 days. 

For reference the 41 year old [Scott Jurek](http://www.npr.org/sections/thetwo-way/2015/07/13/422610986/ultramarathoner-finishes-the-appalachian-trail-in-record-time) can walk the [2000+ mile Appalachian Trail](http://www.nps.gov/appa/index.htm) in 45 days. Single threaded of course. 

## Why is PHPUnit Anti-Performant


Some thing that are inherent to unit tests that make them slow. 

- Tests are usually not well encapsulated 
- Many tests aren't true unit tests - @see integration tests
- Databases must be built and destroyed for every test 
- Connections from local systems are slow 
- Writing to file on a local system is slow 
- Generating reports is intensive 

# Strategies 

## SQLite - In Memory

![SQLite](/images/sqlite.gif)

Switch to an in-memory database. Even if you have SSD drives its going to be slow. [SQLite](https://www.sqlite.org/) is on OS X out of the box I am fairly sure and comes with most 'nix flavors. Considering they embed it all over the place. 

Setting up Laravel it would be something like this: 

```php
'sqlite' => [
    'driver'   => 'sqlite',
//  'database' => storage_path().'/database.sqlite',
    'database' => ':memory:',
    'prefix'   => '',
],
```
Just comment out the hard path. 
Then add a record for the drive in your phpunit.xml 
I also like to make sure my host is set to not kill anything. I have wiped out a dev database or two.  

```xml
<env name="DATABASE_DRIVER" value="sqlite"/>
<env name="DB_HOST" value="NO"/>
```

## Database - Sometimes 

I have two base test cases that I use for almost everything. One that wraps up Laravel or the big framework I'm messing with or one that will just extend phpunit by itself.  It might even be better to have data groups into domains so that when you are running a group of tests that it only loads up those tables. 

We have a couple hundred tests. Not much.  But it takes 2-5 seconds to load up all the data. That adds up to minutes.  Can't handle that. 

## Grouping Test Suites

You have the ability to group your tests. I always have my developers add docblocks such as below so that PHPUnit will know how to group thing. The fields that I want them to use are: 

- @author - for running all mine or someone's tests
- @group - I have them just put the package in this place 
- @namespace - I think this works

```php
/**
 * 
 * @author solvire <stevenjscott@gmail.com>
 * @package Rules
 * @group Rules
 * @namespace LeadFerret\Lib\Rules
 */
 ```

Running `./vendor/bin/phpunit --list-groups` will give you an idea of what groups you can run. 

```
./vendor/bin/phpunit --list-groups
PHPUnit 4.8.16 by Sebastian Bergmann and contributors.

Available test group(s):
 - API
 - Models
 - Rules
 - Transformers
 - default
 - solvire <stevenjscott@gmail.com>
 
```

## Filter Your Tests

Run only the tests you need. Sometimes I'm working with a class and I want to keep running that class.  Just filter by the test class name: 

`./vendor/bin/phpunit --filter="testValidateTrustedCanModifyCompany" `

Make your test names interesting camel cases. If you run testdox it comes out easier to read: 

```
./vendor/bin/phpunit --filter="testValidateTrustedCanModifyCompany" --testdox
PHPUnit 4.8.16 by Sebastian Bergmann and contributors.

LeadFerret\Lib\Rules\CompanyModifyRuleProvider
 [x] Validate trusted can modify company

```

## Turn Off Code Coverage 

You don't always have to run code coverage reports. In fact probably only before a deployment. Either you really love to see code coverage or you hate dealing with unit tests.  Doesn't really seem to be much between.  

### Performance Tests

The difference was so staggering I that I was totally irritated I didn't find this sooner. I was even getting in trying to debug at the lower code level.  

```
./vendor/bin/phpunit --filter="testValidateTrustedCanModifyCompany" --no-coverage
PHPUnit 4.8.16 by Sebastian Bergmann and contributors.
.
Time: 3.98 seconds, Memory: 35.25Mb
OK (1 test, 2 assertions)
```

And with coverage: 

```
./vendor/bin/phpunit --filter="testValidateTrustedCanModifyCompany"
PHPUnit 4.8.16 by Sebastian Bergmann and contributors.
.
Time: 48.54 seconds, Memory: 46.75Mb
OK (1 test, 2 assertions)
Generating code coverage report in HTML format ... done
```

FASTER! 

## JavaScript For The Assist

![GulpJS](/images/gulp.png)

We have been toying with using [Gulp](http://gulpjs.com/) / [NPM](https://www.npmjs.com/) for setting up a better workflow.  It is simple enough that once a file is saved that scripts can kick off the appropriate unit tests. If your tests are completing in less than a couple seconds then it doesn't hurt to keep running them. If they break you may know it sooner.  This is also helpful for those people who refuse to use a full-featured IDE.  Probably also the same people that enjoy working on javascript in the dark.  I know who you are. O.o


# Conclusion 

Life is much better now. 

Test-driven development is a great way to go about things.  I highly suggest it. It makes your life easier in the long run and your credibility as an engineer is safer when you aren't worried about whether you are going to break things. If you automate the process and provide cool reports with graphs then you can build a friendly rivalry based on coverage rights. 


Build Quality Software

_Engineer; Don't Hack_


=st=
