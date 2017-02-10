---
date: 2017-01-15T16:00:07-08:00
draft: false
title: "Django Saleor eCommerce Review"
comments: true
tags: [ technology, django ]
---

# Django And eCommerce

# TL;DR

I setup [Oscar](http://oscarcommerce.com/) as a demo ecommerce project in the [previous post](/post/django-ecommerce-in-30-minutes/).

# Preface


![Saleor](/images/saleor2.png)


# Backstory

I just finished a post about setting up eCommerce with Python Django and wasn't totally pleased with the process. Also I don't think it is fair to only demo a single application.  I decided to give [Saleor](http://getsaleor.com/) my second slot after talking with several people online and looking through its source. The parent company has a number of nice products which was confidence building.


# Pre-setup

As in the previous article, a few things were already installed like PostgreSQL and Python VirtualenvWrapper.

Here are a couple details about my stack.

- Local development: Mac OS X El Cap
- Bitbucket (it's free for private accounts)
- Python VirtualenvWrapper
- Django 1.10.5
- pip 9.0.1
- PostgreSQL 9.5
- Saleor - master branch
- npm 3.8.6
- node v6.0.0
- Python 2.7

Let's Begin

# Local Setup

I'll be following the setup listed in the [Saleor Documentation](https://saleor.readthedocs.io/en/latest/installation.html).

# Setup PostgreSQL

I have installed PostgreSQL locally already. Please see the documentation for more information.

    PostgreSQL 9.5.3 on x86_64-apple-darwin15.4.0, compiled by Apple LLVM version 7.3.0 (clang-703.0.31), 64-bit

Create a database for yourself. You will probably be hitting this locally with socket.

    createdb saleor

## JavaScript

Install the appropriate / required JavaScript components.

    npm i webpack -g


## Virtual Environment - Python

    mkvirtualenv saleor

## Clone The Source

CD into a directory beneath your source location. I like to do /project/source/*

    git clone https://github.com/mirumee/saleor.git
    cd saleor/
    pip install -r requirements.txt
    export SECRET_KEY=`openssl rand -base64 9`
    echo $SECRET_KEY

Keep track of that secret key.

## Build The Schema

I am running PostgreSQL locally.

    sed -i '' 's/saleor:saleor@//' saleor/settings.py
    python manage.py migrate

## Build Front-End

    npm install
    npm run build-assets

Node package install took a while. I thought it was hung so I restarted it and ran it in verbose to know it wasn't dead.

## Dump Schema

I want to add the test data to play with but I may not want it and don't want to have to recreate the database so I dumped the initial schema.

    pg_dump saleor > saleor_orig.sql

Then I added the test data.

    ./manage.py populatedb

# Your Shop

## Run The Server

Kick it off

    ./manage.py runserver

If you did everything right you should be able to see your shop running at http://localhost:8000

I went to create a test account and of course it blew up on the redirect. But that will be investigated later.

![Saleor Home Page](/images/saleor3.png)



## View Dashboard

From the command line I created a superuser so I could see the dashboard.

I liked the dashboard. I think the single page app style is pretty dangerous, but I wanted to give it a try.


![Saleor Home Page](/images/saleor4.png)

## Git Add

Add the new files to the remote repository and push it.

    git init
    git add .
    git commit -m "first commit"
    git remote set-url origin yourname@bitbucket.com:yourapp/yourapp.git
    git push


# Conclusions

## Code Structure

I liked this code layout better than Oscar. It was easier to find my around and seemed cleaner overall. Linting is important to me.

I would have liked to have a separate settings file for local/testing/production such as is in various cookiecutter templates.


## Building

It was easier to build this. Launching it into Heroku blew up on me but this local build did not. That was acceptable. The test data was good enough to play with too.  

## No REST for me

Again, I was disappointed with how hard it was to find information about the REST layer. Please favor mobile and JS heavy deployments. Make things API based first.


## Will it Stay

This is probably the one. I still have to go through a little more testing of course, but I think I am set for now. 
