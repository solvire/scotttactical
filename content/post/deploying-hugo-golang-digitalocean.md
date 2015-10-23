---
date: 2015-10-22T06:29:31-07:00
draft: false
title: Deploying Hugo the Golang CMS on DigitalOcean - Nginx
url: deploying-hugo-golang-digitalocean-nginx
tags: [go, golang, hugo, wordpress, blogging, software, programming]
---

# Deploying Hugo the Golang CMS on DigitalOcean

## Creating a Droplet

I am a bit partial to CentOS. The lastest version as of this writing is _CentOS Linux release 7.1.1503 (Core)_. 

Setting up a droplet is always very simple. Just turn it on basically. Upload your ssh keys. Done. 

## Install Nginx

### Add the epel repo:

	yum install epel-release

### Install

	yum install nginx

### Start it 

	service nginx start 
	systemctl enable nginx

### Create the Folders

	mkdir -p /var/www/ursite/
	chown -R nginx:nginx /var/www
	touch /var/www/ursite/index.html - or clone your site 
	cp /etc/nginx/sites-available/default /etc/nginx/sites-available/ursite

### Configure nginx 

open the config file: `vim /etc/nginx/conf.d/virtual.conf`

Add the following: 

```conf
#
# A virtual host using mix of IP-, name-, and port-based configuration
#

server {
    listen       80;
    server_name  scotttactical.com;
    server_alias go.scotttactical.com;

    location / {
        root   /var/www/stac/public/;
        index  index.html;
    }
}
```

#### Install  Go + Hugo

	yum install go 


I decided to install from source 
Edit your bash script to have the proper variables in place. 

	yum install git hg 
	export GOPATH=$HOME/go
	go get -v github.com/spf13/hugo
	cp $GOPATH/bin/hugo /usr/local/bin/

NOTE: THis actually isn't necessary.  Just check it out and go with it. Afer screwing with it a few minutes I facepalmed... they are static files. Doh! 

