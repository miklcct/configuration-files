# Portable custom configuration files

This repository contains the custom configuration files for various programs
(currently including bash and vim) I am using which I think have sharing values.

These files are designed to be as portable as possible, which I am currently
using on Debian, Ubuntu and Windows machines.

## Bash

### `.bashrc`
This is modified from the default .bashrc found on Ubuntu systems, which
contains the following features.

#### Fedora-style prompt
I have changed the style of the prompt from Ubuntu's default `user@host:dir$ ` to
Fedora's `[user@host dir]$ ` because I think the latter is more readable.

#### Prompt colouring
When colouring is enabled, the prompt is coloured according to the effective
user of the shell:
* green if the shell is running as yourself;
* yellow if the shell is running as another user;
* red if the shell is running as root, or started as an "administrative user"
  under Microsoft Windows.

Moreover, to alert the user if the shell is currently accessed over an SSH
session, the host name is coloured red and printed bold if SSH related
environment variables are found, which reduce the chance of typing commands into
the wrong machine. This will not work if `sudo` clears the environment variables.

#### Git integration
`.bashrc` makes use of `__git_ps1` to show the current git status on the prompt.
If `__git_ps1` is not found, it will attempt to load one from
`~/.git-prompt.sh`. If it is still not found, a stub is defined and git
integration is not available.

#### Chroot prompt
If running inside a Debian chroot, the chroot is prepended into the prompt.

#### xterm title
The current `[user@host dir]` is shown on the xterm title.

### `.bash_aliases`
This is sourced from `.bashrc` to provide useful aliases and shell functions.

### `.colours`
This is sourced from `.bashrc` to define variables for colour escape sequences.

## Vim

### `.vimrc`
This loads the example `vimrc` and set some configuration options which I think is
better.

### `.gvimrc`
This loads the example `gvimrc` and set a prettier font.

## Git
### `.gitignore_global`
This file contains a list of backup files and OS-generated files which should be
ignored by git. Apply it by `git config --global core.excludesfile
'~/.gitignore_global'`
