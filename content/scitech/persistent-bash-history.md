+++
date = 2018-04-06T00:27:13-07:00
categories = []
tags = []
draft = false
title = "Persistent Bash History"
description = "How to store persistent bash history across all terminal instances"
authors = []
socialsharing = true
+++

As a software engineer, I spend a lot of time across multiple terminal instances. When I started
working at Docker, there were several times when I learned a new way to accomplish something, and
then needed to do it again a few weeks later, only to realize I didn't remember the right commands
or arguments. Since regular bash history (the `history` command) isn't very reliable across terminal
instances or reboots, I needed a better solution to maintain all history persistently. For this,
I found a great solution on [Eli Bendersky's website](https://eli.thegreenplace.net/2013/06/11/keeping-persistent-history-in-bash/), which I was able to slightly modify and adapt to my
preferences. You can look at Eli's solution for some useful aliases or trimming of the history,
but I chose not to do that for now. Here's my solution.

In your `.bashrc` file[^1], put the following code:

```
HISTTIMEFORMAT="%d/%m/%y %T "

log_bash_persistent_history()
{
  [[
    $(history 1) =~ ^\ *[0-9]+\ +([^\ ]+\ [^\ ]+)\ +(.*)$
  ]]
  local date_part="${BASH_REMATCH[1]}"
  local command_part="${BASH_REMATCH[2]}"
  # Uncomment the if statement to avoid repeatedly recording the same
  # command when typed inside a single bash session. YMMV.
  # if [ "$command_part" != "$PERSISTENT_HISTORY_LAST" ]

  # this if statement is needed in case the above if statement isn't used
  # because otherwise, pressing enter will create a duplicate entry
  # for the last command that was input
  if [ "$date_part" != "$PERSISTENT_HISTORY_LAST_MOMENT" ]
  then
    echo $date_part "|" "$command_part" "|" "$(pwd)" >> ~/.persistent_history
    export PERSISTENT_HISTORY_LAST="$command_part"
    export PERSISTENT_HISTORY_LAST_MOMENT="$date_part"
  fi
}

# Stuff to do on PROMPT_COMMAND
run_on_prompt_command()
{
    log_bash_persistent_history
}

PROMPT_COMMAND="run_on_prompt_command"
```

This puts all your persistent history across terminals into a file called `~/.persistent_history`.
The important line, in case you want to make any changes, is

```
echo $date_part "|" "$command_part" "|" "$(pwd)" >> ~/.persistent_history
```

Here's a sample of what that looks like

```
06/04/18 10:47:18 | ./release.sh  | /Users/nishant/Git Repositories/hugo-blog-skeleton
06/04/18 10:47:27 | git status | /Users/nishant/Git Repositories/hugo-blog-skeleton
06/04/18 10:47:29 | git add . | /Users/nishant/Git Repositories/hugo-blog-skeleton
06/04/18 10:47:39 | git commit -s -m "Updating submodule" | /Users/nishant/Git Repositories/hugo-blog-skeleton
06/04/18 10:49:07 | git diff | /Users/nishant/Git Repositories/hugo-blog-skeleton
06/04/18 10:50:32 | git diff | /Users/nishant/Git Repositories/hugo-blog-skeleton
06/04/18 10:50:34 | git status | /Users/nishant/Git Repositories/hugo-blog-skeleton
06/04/18 10:50:36 | git add . | /Users/nishant/Git Repositories/hugo-blog-skeleton
```

I chose to record the working directory (`pwd`) because it provides meaningful context. Other than
that, there's not a whole lot going on here.


This has been extremely useful to me in the last year or two that I've used it. The only downside
to doing this that I can imagine is that you're now running a few other commands and writing to
disk each time you run a command on your terminal. I don't think this is really a huge deal
for modern machines, and if I really cared about performance, I'd be writing a separate bash
script anyway.

[^1]: The `.bashrc` file is typically located in the home directory and runs each time you open a new terminal instance.