---
date: 2017-01-05T16:18:32-08:00
draft: false
title: How To Setup a MapR Cluster on Ubuntu
comments: true
---

# How To Install MapR Test Cluster

This document covers my installation of MapR Converged Platform on an Ubuntu 14.04 cluster.

We are running on the DTAC private cloud so some of the screenshots will show our internal interface. All instances are running in a VM.

Most of this follows the suggested flow given in the lab manual from MapR. Initially I launched the cluster on CentOS 7.3 but that wasn't supported and it failed. The same with Ubuntu 16.

## Launch Virtual Machines

I launched 4 virtual machines with the following specs:

- OS: Ubuntu 14.04
- 2 processer cores
- 8GB memory
- 4 disks total
- 1 OS disk @ 8GB
- 3 unformatted disks @ 20GB
- 1 public IP nic  1GbE
- 1 private IP nic  1GbE

![OpenNebula](/images/mapr1.png)


## CsshX

If you are working on multiple servers it's best to use a unified command broadcast tool. It makes life so much easier. This is not the same as the clustershell that will be used from node to node.

    csshx --login root --ssh_args "-i .ssh/YOURKEY" host1 host2 host3 host4

![csshx](/images/mapr2.png)

## SSH keys

You will need to setup passwordless authentication on all the severs. I always do that for external acounts but you need it make sure you can get from node to node.

## HouseKeeping

    apt update
    apt upgrade
    apt install wget unzip clustershell vim htop nfs-common openjdk-7-jdk ntp ntpdate


### Open Security

I don't like this but MapR likes to have the app armor off. I'll be working on getting that or selinux for CentOS back. It could save you some pain later.

    service apparmor stop
    update-rc.d -f apparmor remove


## Keys for Nodes

Set up user mapr and give it keys. Generate keys for the nodes. See [Generate SSH Keys](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/) from Github.


    useradd -m mapr
    usermod -aG sudo mapr
    mkdir /home/mapr/.ssh
    cp ~/.ssh/authorized_keys /home/mapr/.ssh/
    vim ~/.ssh/id_rsa
    cp ~/.ssh/id_rsa /home/mapr/.ssh/
    chmod 600 ~/.ssh/id_rsa /home/mapr/.ssh/id_rsa /home/mapr/.ssh/authorized_keys
    chown mapr:mapr -R /home/mapr/.ssh

## Hostnames

It is important for the servers to have the hostnames to the local internal IP addresses set. I use AWS Route53 and that seems to work fine. Of course I need external connectivity to get out to their DNS. I set up the internal host names as mapr1-4 and add a DNS search parameter to the resolv.conf

## Clustershell

The cluster shell should have been installed via apt above.

Edit the cluster shell config.

    vim /etc/clustershell/groups
    echo "all: <IP addr 1> <IP addr 1> <IP addr 2> <IP addr 4>" >> /etc/clustershell/groups

Then scan for the keys.

As root and mapr

    ssh-keyscan <IP addr 1> <IP addr 1> <IP addr 2> <IP addr 4> >> ~/.ssh/known_hosts


Test it:

    clush -a date

## Set up ntpd

You will need to set up a local ntp server according to your own documentation. This is recommended by the MapR documentation.


# Install MapR

## Download the Lab Files

This install was done while going through the MapR training lab. So I have used their files for this purpose.

    mkdir /opt/mapr
    cd /opt/mapr
    wget http://course-files.mapr.com/ADM2000/ADM200_Lab1.2.zip
    unzip ADM200_Lab1.2.zip
    ls labfiles

## Run Validation


### Run a Cluster Audit

    ./labfiles/cluster-audit.sh | tee cluster-audit.log

You shouldn't see any errors or exit codes. Please fix if you find them.

### Evaluate Network Bandwidth

Here is where I really realized that I need faster networking in our data center. I will be posting an updated article after I have had time to build and upgrade the networking.

    ./labfiles/network-test.sh | tee network-test.log

    172.16.0.50: server-172.16.0.48-rpctest.log:Rate:  58.65 mb/s, time: 89.4174 sec, #rpcs 20007, rpcs/sec 223.748
    172.16.0.49: server-172.16.0.47-rpctest.log:Rate:  58.65 mb/s, time: 89.4173 sec, #rpcs 20007, rpcs/sec 223.749

### Evaluate Data Flow

    clush -Ba /opt/mapr/labfiles/memory-test.sh | tee memory-test.log

Stream will give you some interesting information about your throughput.

    -------------------------------------------------------------
    Function      Rate (MB/s)   Avg time     Min time     Max time
    Copy:       13793.8268       0.0963       0.0928       0.1045
    Scale:      15898.8540       0.0843       0.0805       0.1087
    Add:        20007.9099       0.0993       0.0960       0.1102
    Triad:      19926.1249       0.0994       0.0964       0.1068

### Evaluate Raw Disk Performance

Be careful. This will erase everything on the disks. We set up 3 disks on each node but since they are obviously virtual let's just run it on one. I also don't feel like beating up SSD's like this so I skip it sometimes.

    clush -Ba /opt/mapr/labfiles/disk-test.sh

## Install A MapR Cluster

### Get the Installer

    wget http://package.mapr.com/releases/installer/mapr-setup.sh
    bash mapr-setup.sh

Run through the setup and let it know what you decide. It will probably try to install several dependencies.

![MapR Installer](/images/mapr3.png)

## Finish Install

Go to the GUI and run through the rest of the install. The installer will give you the url and the port.

    https://YOURHOST:9443/

![MapR GUI Installer](/images/mapr4.png)

You will be notified of any discrepancies. It is best not to ignore these in a production environment. Of course I didn't have enough room on certain things, but I went ahead anyway.

![MapR GUI Installer](/images/mapr5.png)
