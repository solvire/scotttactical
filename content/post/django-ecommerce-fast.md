---
date: 2017-01-14T16:00:07-08:00
draft: false
title: "Django eCommerce in 30+ Minutes"
comments: true
tags: [ technology, django ]
---

# Django And eCommerce

# TL;DR

Python has potential for eCommerce. I went through the [well known products](https://djangopackages.org/grids/g/ecommerce/) and settled on Oscar as my demo. It took a while to set up, but was pretty full featured. Python and Django still have to compete with short busses like wordpress and dump trucks like Magento, but I think these tools are ready for me to start pushing.

# Preface

Let me say this took me almost 2 days to get through and evaluate, which I'm used to having a demo site up in minutes. After having gone through, I think this could be launched in half an hour.  Below are my notes of the process.

# Backstory

I was contacted by a business partner to see if we could kick off a project to distribute some substances that newly became legal here in CA. I thought I could spin up an ecommerce app in a couple hours and be taking payments in a week. I wanted to see how fast I could do this with Django. Most my previous eCommerce deployments (many) were in PHP and many of them were in [magento](https://magento.com). Had a few in ASP, Perl, (Websphere) Java. I'm over that pain.

I will append this by saying a few things were already installed like PostgreSQL and Python VirtualenvWrapper.

Here are a couple details about my stack.

- Local development: Mac OS X El Cap
- Bitbucket (it's free for private accounts)
- Python VirtualenvWrapper
- Django 1.9
- PostgreSQL 9.5
- Django-Oscar


Let's Begin

# Local Setup

# Setup PostgreSQL

I have installed PostgreSQL locally already. Please see the documentation for more information.

    PostgreSQL 9.5.3 on x86_64-apple-darwin15.4.0, compiled by Apple LLVM version 7.3.0 (clang-703.0.31), 64-bit

Create a database for yourself. You will probably be hitting this locally with socket.

    createdb [project_slug]


## Virtual Environment - Python

Python 2.7

Yes I know.

I'm still not on P3. Leave me alone, gosh. There is always some library that causes me pain. I make it future-proof as much as possible though.

    mkvirtualenv yourapp

CD into a directory beneath your source location. I always do /project/source/*

## Install cookiecutter-django

I have used this [cookiecutter](https://github.com/pydanny/cookiecutter-django) before so I stick with what I know.

    cookiecutter https://github.com/pydanny/cookiecutter-django

Go through the questions.

Add the new files to the remote repository and push it.

    git init
    git add .
    git commit -m "first commit"
    git remote add origin yourname@bitbucket.com:yourapp/yourapp.git
    git push -u origin master

## Django Setup

I decided to try out Django Oscar. I figure it is the most popular. And also hoping it isn't the most bloated.

Add oscar to the bottom of the requirements file.

    vim requirements/base.txt
    -e git+https://github.com/django-oscar/django-oscar.git@master#egg=django-oscar
    django-compressor==2.1
    pycountry==17.1.8

There is a problem with oscar and Django 1.10 so pull the latest from master. I also had to modify the source to get the middleware to work as well. Small enough problems that I didn't totally abandon the project at this point. https://github.com/django-oscar/django-oscar/issues/2205 I entered a code fix + pull request so hopefully it is fixed. There was also a problem with the pycountry change as listed below.


Now pip install everything.

    pip install -r requirements/local.txt

This should bring in everything you need.

Copy the environment template file.

    cp env.example config/settings/.env

Run the manage command to confirm.

    ./manage.py

# Set Up Oscar

in `yourapp/config/settings/common.py`

Add 'oscar' to the third party installed applications in the settings file.

According to the [documentation](https://django-oscar.readthedocs.io/en/latest/internals/getting_started.html#django-settings) update the settings for the templates.


```python
# Import all the oscar items
from oscar import OSCAR_MAIN_TEMPLATE_DIR
from oscar import get_core_apps
from oscar.defaults import *

```

```python

DJANGO_APPS = (
    # Default Django apps:
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.sites',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'django.contrib.flatpages',

    # Useful template tags:
    # 'django.contrib.humanize',

    # Admin
    'django.contrib.admin',

)
THIRD_PARTY_APPS = (
    'crispy_forms',  # Form layouts
    'allauth',  # registration
    'allauth.account',  # registration
    'allauth.socialaccount',  # registration

    # the oscar apps
    'compressor',
    'widget_tweaks',
    'pycountry'
) + tuple(get_core_apps())

```

```python
MIDDLEWARE_CLASSES = (
    ...
    'oscar.apps.basket.middleware.BasketMiddleware',
    'django.contrib.flatpages.middleware.FlatpageFallbackMiddleware',
)
```


```python
TEMPLATES = [
    {
        # See: https://docs.djangoproject.com/en/dev/ref/settings/#std:setting-TEMPLATES-BACKEND
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        # See: https://docs.djangoproject.com/en/dev/ref/settings/#template-dirs
        'DIRS': [
            str(APPS_DIR.path('templates')),
            OSCAR_MAIN_TEMPLATE_DIR
        ],
        'OPTIONS': {
            # See: https://docs.djangoproject.com/en/dev/ref/settings/#template-debug
            'debug': DEBUG,
            # See: https://docs.djangoproject.com/en/dev/ref/settings/#template-loaders
            # https://docs.djangoproject.com/en/dev/ref/templates/api/#loader-types
            'loaders': [
                'django.template.loaders.filesystem.Loader',
                'django.template.loaders.app_directories.Loader',
            ],
            # See: https://docs.djangoproject.com/en/dev/ref/settings/#template-context-processors
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.template.context_processors.i18n',
                'django.template.context_processors.media',
                'django.template.context_processors.static',
                'django.template.context_processors.tz',
                'django.contrib.messages.context_processors.messages',
                # Your stuff: custom template context processors go here
                'oscar.apps.search.context_processors.search_form',
                'oscar.apps.promotions.context_processors.promotions',
                'oscar.apps.checkout.context_processors.checkout',
                'oscar.apps.customer.notifications.context_processors.notifications',
                'oscar.core.context_processors.metadata',
            ],
        },
    },
]

```

This allows the users to log in with email as well as username, but I don't know if I will use that.

```python
AUTHENTICATION_BACKENDS = (
    'oscar.apps.customer.auth_backends.EmailBackend',
    'django.contrib.auth.backends.ModelBackend',
    'allauth.account.auth_backends.AuthenticationBackend',
)
```

At the bottom set the haystack settings.

```python
HAYSTACK_CONNECTIONS = {
    'default': {
        'ENGINE': 'haystack.backends.simple_backend.SimpleEngine',
    },
}
```

## Set the URLs


Here is my url file.

```python
...
from oscar.app import application

urlpatterns = [
    # url(r'^$', TemplateView.as_view(template_name='pages/home.html'), name='home'),
    url(r'^about/$', TemplateView.as_view(template_name='pages/about.html'), name='about'),

    # Django Admin, use {% url 'admin:index' %}
    url(settings.ADMIN_URL, admin.site.urls),

    # User management
    url(r'^users/', include('yourapp.users.urls', namespace='users')),
    url(r'^accounts/', include('allauth.urls')),

    # Your stuff: custom urls includes go here
    url(r'^i18n/', include('django.conf.urls.i18n')),
    url(r'', include(application.urls)),

] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

if settings.DEBUG:
    ...
```

## Build Schema

If the database is created and you set up everything properly you should be able to build the DB schema now.

    ./manage.py migrate

## Start Local

Kick off the local server.

    ./manage.py runserver_plus

If everything works properly you should be able to go to http://localhost:8000/ and see your new project running.

# Store Setup

This wasn't quite enough for me so I needed to add some products into the application really quickly to see the catalogue.

## Install Shipping Countries

Pycountry should have been installed already, and it was suggested to load all the countries in the oscar documentation.

    ./manage.py oscar_populate_countries --no-shipping

This threw an attribute error. At this point I am thinking this application may be a bit fragile. There is a pull request for it so I just manually made the change and it worked. https://github.com/django-oscar/django-oscar/pull/2182

I'm annoyed at pycountry for a menial change like that. Or provide a better SDK.

## Where Templates Are?

I realized that the templates were not seen even though they were in the path. I just copied them from the oscar sandbox example so that I had more to go off of.

    /src/oscar/templates/oscar/*

I also copied over all the static content into the media directory.

    /src/oscar/static/oscar/img > yourapp/static

## Dashboard

Make sure you created a superuser account.

Login and travel to the dashboard: http://127.0.0.1:8000/dashboard/

## Product Setup

You need to have a category and a shipper. That is easy enough to set up. I added a couple products and viewed them on the

![Product Page](/images/oscar1.png)

![Dashboard](/images/oscar2.png)

# Conclusions

## Code Structure

This looked fine to me. I was able to find my way around very easily compared to the likes of Magento, IBM, SAP. Thank goodness. That is stuff of nightmares.

## Loaders

The framework is important to me. I like to see proper recognizable patterns. There were red flags with the model class "loader" paradigm when I expected to see Django objects. I think that is unnecessary with a framework that has good bootstrapping functionality such as Django. Maybe someone can explain where my thinking is in error.

## No REST for me

I was disappointed with how hard it was to find information about oscar and an integration with a REST layer. Most sites MUST support mobile. And probably should support mobile FIRST. The old days of a monolithic website stack are kinda over. Especially with javascript running rampage over the facades of the interwebs.

Yes, I know there is [django oscar api](https://github.com/django-oscar/django-oscar-api) - It needs more thorough documentation, and matrix of supported features would be nice. Overall it looks promising.

## Performance

The application felt kinda slow. Maybe it can be optimized, but for a starter, I felt like it should be more responsive. The feel of other apps was a little better. With ecommerce the most important thing is checkout flow followed by performance and product data.  Don't skimp on ANY of those things.  Let the design languish if you have budget for a performance hacker. I've launched large ecommerce sites and this is what killed most of them once traffic rolled in.


## Will it Stay

I still have to look through [Saleor](http://getsaleor.com/) and [Cartrige on Mezzanine](http://mezzanine.jupo.org/) which were very appealing. I also wanted to have a hand at setting up an ecommerce app in Go, but the lack of templating and abstraction that python is good at was a knock down.
