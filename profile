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

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# ~/.local/bin
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin/:$PATH"
fi

# PATH includes /sbin and the like
# PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"

# SSHfs Exec
if [ -d "$HOME/bin/sshfsexec" ] ; then
    PATH="$HOME/bin/sshfsexec:$PATH"
fi

# Python - pyenv
if [ -d "$HOME/.pyenv/bin" ] ; then
    PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
fi

# Python - anaconda
# added by Anaconda3 4.0.0 installer
PATH="$PATH:/home/local/ANT/anntoinw/bin/anaconda3/bin"

# Ruby - rbenv
if [ -d "$HOME/.rbenv/bin" ] ; then
    PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

# Javascript - nvm
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
