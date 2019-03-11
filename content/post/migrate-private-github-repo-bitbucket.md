---
date: 2016-02-23T21:28:23-08:00
title: Migrate A Private GitHub Repository to Free Bitbucket in Roughly 7 Easy Steps
tags: [ software ]
url: migrate-private-github-repo-bitbucket
comments: true
---

## Why Not GitHub

### GitHub is Great

Don't get me wrong. I would recommend using this service for a number of reasons that are not fiscally motivated. It isn't whether GitHub.com is good or not. There is a matter of economics at play though.

As a startup I just don't have the extra 25/mo to throw into GitHub business account. It looks cool that I have an organization there and there are more badges.  But it doesn't work at 12 X $25 = $300/yr. Bottom account. Bronze I think it is.

### GitHub is Mas Rico

It is cheap if you are a big corporation but for a small shop or a single coder with some sensitive code it doesn't make sense.

## Why Bitbucket

[Bitbucket](https://bitbucket.org/) is tied into [Atlassian](https://www.atlassian.com/software/bitbucket). There are a lot of advantages if that is your enterprise process software provider.  Having it link in with [Confluence](https://www.atlassian.com/software/confluence) and [Jira](https://www.atlassian.com/software/jira) is pretty nice.

It is also a much more manageable pricing structure.  Free 99 for private! Yeah once you have more than 5 accounts it starts to charge.

## Moving From GitHub to Bitbucket

Ok let's move.

### Create A Team

At the top of the navigation select the Teams >> Create team.

![Create Team](/images/github-bitbucket-migration-1.png)

Follow the steps. It will tell you obvious things like "You don't have any code". There are also no members in your team but you can deal with that later.



### Import a Repository from GitHub

Thankfully the developers at Atlassian are aware of migrants coming in and provided a convenient button to the

![Import a repository](/images/github-bitbucket-migration-2.png)

### Set up the new repository

There are some helpful notes to guide you throught he process. Add your credentials and hit "Import repository".

![Import a repository](/images/github-bitbucket-migration-3.png)

1. Select git
2. Select "Requires authorization"
3. Copy the HTTPS URL from your GitHub account

Note: if you have two-factor authentication on you will have to disable it for the import.

![Copy URL](/images/github-bitbucket-migration-4.png)

### Change the Origin URL

Now that you have created the new repository you need to update your git repo to point to the new repository.  

CD into your local source directory.

  git remote -v

This will show you where you are still pointing. Now you will need to edit the git config.

  vim .git/config

Change the [remote "origin"] section `url` to point to your new repo. Located in the upper right of your new repository.

Make sure you upload the proper keys and things of that nature.  

This is a handy command for picking up the ssh public keys:

  cat ~/.ssh/id_rsa.pub | pbcopy

### Delete the GitHub Repository

Once you feel confident that your repository is functioning in an acceptable form, DELETE your repository. With extreme care.

![Settings](/images/github-bitbucket-migration-5.png)

![Delete Repo](/images/github-bitbucket-migration-6.png)

I was a little puckered up when I hit the red button. I am not going to lie.  

![Nuke It!](/images/github-bitbucket-migration-7.png)


### Invite to Your Party

Go ahead and send out invitations to your team members now.  

### Downgrade your GitHub Account

  Go to account settings (or organization settings)
  Go to billing tab
  Click on change plan tab
  Downgrade to a free account

## Conclusion

That is about it.  That isn't very painful. It is probably wise to do early on if you have any intention of using the Atlassian tools.  We switched to Jira at the next to previous place a while before. They have a great sales team there so it is very likely that one of your business managers will get hoodwinked into it. Fancy brochures and talking about culture and productivity will peak.

### PS

Btw. If you don't use a source code repository then please let me know so I can keep from wasting my time with any interviews with your company.
