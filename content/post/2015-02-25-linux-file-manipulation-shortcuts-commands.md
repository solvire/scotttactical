---
title: Linux File Manipulation Shortcuts and Commands
author: SScott
date: 2015-02-25
url: /linux-file-manipulation-shortcuts-commands/
categories:
  - Uncategorized
tags: [ linux ]
image: images/baveria.jpg
---
# Linux File Manipulation Commands

I'll keep updating this with various commands that I run into. If I find new ones I'll update them from time to time. Please feel free to comment. It is starting as my personal cheat sheet storage place.

## File Searching

**List of file extensions.**

awk + grep : find all the file extensions. It will also skip your "git" repository.

`find . -type f -name "*.*" ! -path "./.git/*" | awk -F. '!a[$NF]++{print $NF}'`

To get the count then simply add \`wc\` command.

`find . -type f -name "*.*" ! -path "./.git/*" | awk -F. '!a[$NF]++{print $NF}' | wc -l`

## Vim Commands

To find non-ascii characters in your file:

`/[^\x00-\x7F]`

## Logs

### Apache Logs

Find count of unique IP addresses

Get the IP's - usually the first item

`$ awk '{ print $1 } ' access_log`

Sort them

`$ awk '{ print $1 } ' access_log | sort`

They get only the unique items using the uniq command. You can count these if you want.

`$ awk '{ print $1 } ' access_log | sort | uniq`

To get the counts and sort them by totals.

`$ awk '{ print $1 } ' access_log | sort | uniq -c | sort -n -k 1`

If you only want to show the highest numbers.

`$ awk '{ print $1 } ' access_log | sort | uniq -c | sort -n -k 1 | tail`
