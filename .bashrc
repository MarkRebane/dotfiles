# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
export LESSCHARSET='utf-8'
export PAGER=less

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-colour, unless we know we "want" colour)
case "$TERM" in
    xterm-color )
        color_prompt=yes
        normal="\033[0m"  #reset
        em1="\033[32m"    #green
        em2="\033[31m"    #red
        em3="\033[34m"    #blue
        em4="\033[33m" ;; #yellow
    *-256color )
        color_prompt=yes
        normal="\033[0m"        #reset
        em1="\033[38;5;120m"    #green
        em2="\033[38;5;211m"    #pink
        em3="\033[38;5;153m"    #blue
        em4="\033[38;5;186m" ;; #yellow
esac

# MotD
echo -e "${em1}This is BASH ${em2}${BASH_VERSION%.*} ${em1}- DISPLAY on ${em2}$DISPLAY ${em1}- TERM running ${em2}$TERM${normal}"
echo -e "$em4$(date)$normal"

# uncomment for a coloured prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes
# Shell Prompt

if [[ "${DISPLAY%%:0*}" != "" ]]; then
    hilit=${em3} # remote machine
else
    hilit=${em2} # local machine
fi

function parse_git_branch {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "("${ref#refs/heads/}")"
}

function fastprompt() {
    unset PROMPT_COMMAND
    case $TERM in
        *term | rxvt* )
            PS1="${hilit}[\h]${normal} \w $ \[\033]0;\${TERM} [\u@\h] \w\007\]" ;;
        linux )
            PS1="${hilit}[\h]${normal} \w $ " ;;
        * )
            PS1="[\h] \w $ " ;;
    esac
}

function powerprompt() {
    case $TERM in
        *term* | rxvt* )
            PS1="\n$em2[${hilit}\u@\h$em2:$em1\#$em2:$em1\w$em3\$(parse_git_branch)$em2]\n$em1<\t>\$ $normal" ;;
        linux )
            PS1="\n$em2[${hilit}\u@\h$em2:$em1\#$em2:$em1\w$em3\$(parse_git_branch)$em2]\n$em1<\t>\$ $normal" ;;
        * )
            PS1="\n[\u@\h:\#:\w]\n<\t>\$ " ;;
    esac
}

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have colour support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    powerprompt
else
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    fastprompt
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable colour support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# personal aliases
alias mkdir='mkdir -p'
alias ..='cd ..'

# coloured GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi
fi
alias tmux='tmux -2'

if [ -f $HOME/.bashrc_aliases ]; then
    source $HOME/.bashrc_aliases
fi
