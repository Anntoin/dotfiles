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

# SSHfs Exec
if [ -d "$HOME/bin/sshfsexec" ] ; then
    PATH="$HOME/bin/sshfsexec:$PATH"
fi

# PATH includes /sbin and the like
PATH=$PATH:"/usr/local/sbin:/usr/sbin:/sbin"

# Pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"

# Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init -)"

# added by Anaconda3 4.0.0 installer
export PATH="$PATH:/home/local/ANT/anntoinw/bin/anaconda3/bin"

export PATH="$PATH:$HOME/.local/bin/"

# NVM
export NVM_DIR="/home/local/ANT/anntoinw/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
export PATH=$PATH:$(npm config --global get prefix)/bin

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

