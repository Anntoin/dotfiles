# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

export LANG="en_GB.utf-8"

#---------------------------------------------------
# Path
#---------------------------------------------------

# Reset PATH to sane defaults (include /sbin and the like)
PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"

# ~/.local/bin
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin/:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# SSHfs Exec
if [ -d "$HOME/bin/sshfsexec" ] ; then
    PATH="$HOME/bin/sshfsexec:$PATH"
fi

# Python - pyenv
if [ -d "$HOME/.pyenv/bin" ] ; then
    PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
fi

# Ruby - rbenv
if [ -d "$HOME/.rbenv/bin" ] ; then
    PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

# Javascript - nvm (considering switching to nodenv)
NVM_DIR="/home/local/ANT/anntoinw/.nvm"
if [ -d "$NVM_DIR" ] ; then
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    PATH=$PATH:$(npm config --global get prefix)/bin
fi

# Export PATH once
export PATH

#---------------------------------------------------
#
#---------------------------------------------------

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi
