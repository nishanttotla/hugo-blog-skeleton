+++
categories = ["Technical"]
date = "2016-03-11T13:35:12-08:00"
description = "A guide to writing code in your Mac and building inside a VM"
draft = false
socialsharing = true
tags = ["programming", "development"]
title = "Building Code Inside a VM"
aliases = ["/articles/building-code-inside-vm/"]

+++

This post is based on the workflow I've been employing during my day to day work at Docker. When I first started, I chose to get a 13' Macbook Pro, which is a pretty solid machine to own. But a lot of the compiling and testing I needed to do needed a Linux distribution, so I had two options -- install Linux or use a Virtual Machine (VM). Installing VirtualBox and using a simple Ubuntu VM is a fairly straightforward solution, but there were two problems

- I really wanted to continue writing code on OSX (personal preference)
- I don't think VirtualBox is very stable, and it would be a disaster to lose my work if something bad happened

The solution was the continue writing code on the Mac, but build it inside the VM -- a win-win. But how?

The first solution I came up with involved using `rsync`, a very popular file synchronization tool for Unix-like systems. I set up one folder called `work` on my Mac, and one on the VM, and used `rsync` to copy files from one to the other. Any changes were automatically detected using `inotify` (or similar tools), and triggered a sync. I won't describe that in detail because it's not only fragile and prone to corruption[^1], but also too hard to set up[^2]. All this was before I discovered that I could mount folders (duh) and create a relatively stable solution. If this is something you're interested in too, read on!

### Setting up a mounted folder on a VirtualBox VM

It's relatively easy to create a VM using your Linux distribution of choice. I use Ubuntu 14.04 right now, but the setup should work in most cases. Once you've installed the VM, make sure you install `openssh-server` to be able to SSH into it from the host[^3].

```
$ sudo apt-get install openssh-server
```
The other requirement is Guest Additions, without which mounting won't work. It's straightforward to install, and [several articles](http://askubuntu.com/questions/22743/how-do-i-install-guest-additions-in-a-virtualbox-vm) online explain how to do it.

Now we need to create a mounted folder. Right click on the VM and go to Settings, under Shared Folders. There, mount your folder of choice as a Machine Folder, and give it a name. I mount the `work` folder in my home directory, and call the mount `workmac` (any name is fine).

<figure>
    <img data-action="zoom" src="/images/vbox-shared-folder.png" style="width:100%;"></img>
</figure>

Finally, SSH into the VM, then create a folder, which will be the mount point for the host folder. In my case, it's in the home directory  and called `work-vm`. The shared folder is mounted with 770 permissions with `root` user and `vboxsf` as the group. This is an inconvenience since you (the user) also want to have those permissions. This is done by adding the user to to `vboxsf` group as follows

```
$ sudo usermod -aG vboxsf $(whoami)
```
Finally, mount the folder

```
$ sudo mount -t vboxsf -o uid=$UID,gid=$(id -g) workmac work-vm
```
Change the mount and directory names as appropriate for you. And that's it! Now you should be able to access a mirror of the host folder inside the VM without any of the messy `rsync` scripts. Note that if you reboot the VM, you'll have to run the mount command again -- a requirement you can surpass by adding the line to your `.bashrc` file.

### Advantages of this setup
It's an extremely simple setup that has worked for me (and others I helped) each time. While for me, the reasons to do this centered around personal preference, I feel there are at least two good reasons to do it anyway

- The environment inside a VM can be precisely controlled, and doesn't have to depend on, or mess with the host (Mac). It's really easy to upgrade, or redo if things are failing. This also makes it easy to quickly experiment with different build environments.
- The setup is easier to reproduce and share with someone else.

So far, my use cases haven't presented any disadvantages, though I suspect there could be situations where this couldn't work. Feel free to share your experiences in the comments. The next step I'd like to explore would be to create a similar dev environment [using Docker](http://www.ybrikman.com/writing/2015/05/19/docker-osx-dev/) instead.

[^1]: You don't want to know how git config files can go crazy.
[^2]: I'm surprised I even had to patience to go through all the steps.
[^3]: To save some trouble if your Mac reboots, you might want to set a static IP address for the VM. How to do that is beyond the scope of this post.