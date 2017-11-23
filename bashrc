#---------------------------------------------------
# Work specific configs
#---------------------------------------------------

source ~/.bashrc.work

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=9999
HISTFILESIZE=9999

# vi style keybindings
set -o vi

# Enable autocompletion when using sudo
complete -cf sudo

# correct minor spelling errors in cd commands
shopt -s cdspell

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Editor variable
export EDITOR=vim

# Make java apps less ugly
# 27 Jun 2013: Davmail crashes with these options
#export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"

# Shouldn't really be nessecary but...
[[ -f ~/.Xresources ]] && xrdb ~/.Xresources

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

source <(awless completion bash)

#----------------------------------------------------------------------#
# Aliases
#----------------------------------------------------------------------#

# scratchpad function, note quote madness
function scratch
{
    xterm -title scratchpad -e 'vim -n -c "let g:auto_save = 1" + ~/Documents/Logs/scratchpad-$(date +'%d-%b-%Y').md' &
}

# git
function git-grope()
{
    git grep $@ $(git rev-list --all)
}

# tmux always use 256 colours
alias tmux='ssh_auth_save; export HOSTNAME=$(hostname); tmux -2'

# taskwarrior testing
alias task-test='task rc:~/.taskrc_test'

# SSH configs
alias ssh="cat ~/.ssh/config.d/* > ~/.ssh/config ; ssh"

# # wget always resumes
alias wget='wget -c'

# code formatting
alias style='astyle --style=allman'

# Damn I hate emacs keybindings
alias info='info --vi-keys'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#----------------------------------------------------------------------#
# Functions
#----------------------------------------------------------------------#

# From http://www.commandlinefu.com/commands/view/12127/call-vim-help-page-from-shell-prompt?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+Command-line-fu+%28Command-Line-Fu%29
function :h { vim +":h $1" +'wincmd o' +'nnoremap q :q!<CR>' ;}

# Ranger changes to last directory after exit
function ranger
{
    tempfile='/tmp/chosendir'
    $(which ranger) --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
      cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}

# Taskwarrior filter project by directory
# From: http://danieldvork.in/use-current-directory-as-taskwarrior-project-filter/
function project
{
    project=$(basename `pwd`);
    tp=( $(task _projects | grep $project) );

    if [[ -n $tp ]]; then
        task "$@" project:$project;
    else
        task "$@"
    fi
}

# TMUX
ssh_auth_save() {
    rm "$HOME/.ssh/ssh-auth-sock.$HOSTNAME"
    ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh/ssh-auth-sock.$HOSTNAME"
}

forward_port()
(
    help()
    {
        echo >&2 "usage: $0 host port"
        exit 1
    }

    if [ $1 ] && [ $2 ]; then
        HOST=$1
        PORT=$2
    else
        help
    fi

  	ssh -fNL $PORT:localhost:$PORT $HOST
)

#---------------------------------------------------
# Prompt
#---------------------------------------------------

source ~/.prompt-colours.sh
source ~/.git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWCOLORHINTS=true
PROMPT_COMMAND='__git_ps1 "$NONE[$BLUE\t$NONE] [$PURPLE\W$NONE] " "[$GREEN\$$NONE]➱ $NONE" "[%s$NONE] "'
PS1="$NONE[$BLUE\t$NONE] [$PURPLE\W$NONE] [$GREEN\$$NONE]➱ $NONE"

