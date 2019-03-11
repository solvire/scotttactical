---
date: 2016-12-24T06:41:07-08:00
draft: false
title: Encrypt PostgreSQL Backup to S3
tags: [ devops, data]
comments: true
---


## Encrypt Your DB Backups

I'm mostly putting this here for my reference. I do this in multiple projects and always seem to forget where my instructions are.

### Generate Keys

From your user's home directory:

  openssl req -x509 -nodes -days 1000000 -newkey rsa:4096 -keyout .ssh/backup_key.pem -out .ssh/backup_key.pem.pub

Fill out the questions appropriately. Or not. I don't think it matters really.

That will create the public and private keys.

  backup_key.pem - private key
  backup_key.pem.pub - public key

### Add AWS Keys

Create a file to hold your AWS keys.

  mkdir ~/.aws
  vi ~/.aws/credentials

Here is the format:

```
[default]
aws_access_key_id = ACCESSKEY
aws_secret_access_key = SECRETKEY
aws_region = us-east-1
```

## Backup Script

I don't want to bore with details but here is what this script will do from a high level:

1. Take DB name
2. Set the backup file name with timestamp
3. dump the DB with pg_dump
4. remove the old versions
5. copy to s3 for storage

```bash
!/bin/bash
## #######################

## Database Name
database_name="$1"
backup_public_key="/HOMDIR/.ssh/backup_key.pem.pub"

## Location to place backups.
backup_dir="/tmp/db_backups/"
## Numbers of days you want to keep copies of your databases

number_of_days=10
if [ -z "${database_name}" ]
then
 echo "Please specify a database name as the first argument"
 exit 1
fi

## String to append to the name of the backup files
backup_date=`date +%Y-%m-%d-%H-%M-%S`
backup_name="${database_name}.${backup_date}.sql.bz2.enc"
echo "Dumping ${database_name} to ${backup_dir}${backup_name}"

pg_dump ${database_name}|bzip2|openssl smime -encrypt \
 -aes256 -binary -outform DEM \
 -out ${backup_dir}${backup_name} \
 "${backup_public_key}"

find ${backup_dir} -type f -prune -mtime \
    +${number_of_days} -exec rm -f {} \;

## push file to S3
aws s3 cp ${backup_dir}${backup_name} s3://YOURBUCKET/db_backup/

```

### Crontab

Set up a crontab for this script. This one fires off at 3am PT daily. Change as needed.

  crontab -e
  0 3 * * * /location/pg_backup.sh YOURDB

## Decrypt

Decryption is pretty straight forward. Get your private key and pull the file from S3.

  openssl smime -decrypt -in my_database.sql.sql.bz2.enc -binary -inform DEM -inkey private.pem | bzcat >  my_database.sql.sql

## Credits

https://www.imagescape.com/blog/2015/12/18/encrypted-postgres-backups/
