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
no_colour='\033[0m'
# Palette entires 0-7
palette00="\033[0;30m" # Black
palette01="\033[0;31m" # Red
palette02="\033[0;32m" # Green
palette03="\033[0;33m" # Brown
palette04="\033[0;34m" # Blue
palette05="\033[0;35m" # Purple
palette06="\033[0;36m" # Cyan
palette07="\033[0;37m" # Light Gray
# Palette entires 8-15
palette08="\033[1;30m" # Dark Gray
palette09="\033[1;31m" # Light Red
palette10="\033[1;32m" # Light Green
palette11="\033[1;33m" # Yellow
palette12="\033[1;34m" # Light Blue
palette13="\033[1;35m" # Light Purple
palette14="\033[1;36m" # Light Cyan
palette15="\033[1;37m" # White

# MotD
echo -e "${palette01}This is BASH ${palette02}${BASH_VERSION%.*}"              \
    "${palette01}- DISPLAY on${palette02}${DISPLAY}"                           \
    "${palette01}- TERM running ${palette02}${TERM}${no_colour}"
echo -e "${palette05}$(date)${no_colour}"

# uncomment for a coloured prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_colour_prompt=yes
# Shell Prompt

if [[ "${DISPLAY%%:0*}" != "" ]]; then
    hilite=${palette05} # remote machine
else
    hilite=${palette10} # local machine
fi

function parse_git_branch() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "("${ref#refs/heads/}")"
}

function fastprompt() {
    unset PROMPT_COMMAND
    if [ "${1}" = colour ]; then
        case $TERM in
            # If this is an xterm set the title to:
            # user@host:dir$
            xterm* | rxvt* | linux )
                PS1="${debian_chroot:+($debian_chroot)}${hilite}\u@\h${no_colour}:\w\$ " ;;
            * )
                # Why are we distinguishing terminals?
                # What can we do with this information?
                ;;
        esac
    else
        PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w\$ "
    fi
}

function powerprompt() {
    unset PROMPT_COMMAND
    if [ "${1}" = colour ]; then
        case ${TERM} in
            # If this is an xterm set the title to:
            # user@host:#:dir(branch)
            # 00:00.00 $
            xterm* | rxvt* | linux )
                PS1="${debian_chroot:+($debian_chroot)}${hilite}\u@\h${no_colour}:${palette12}\#${no_colour}:${palette10}\w${palette04}\$(parse_git_branch)\n${palette10}\t${no_colour} \$ " ;;
            * )
                # Why are we distinguishing terminals?
                # What can we do with this information?
                ;;
        esac
    else
        PS1="${debian_chroot:+($debian_chroot)}\u@\h:\#:\w\n\t \$ "
    fi
}

if [ -n "${force_colour_prompt}" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have colour support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        colour_prompt=colour
    else
        colour_prompt=
    fi
else
    colour_prompt=colour
fi

#fastprompt $colour_prompt
powerprompt $colour_prompt
unset colour_prompt force_colour_prompt

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
# FIXME does this have quote errors?
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

function __loc() {
    find "$@" \
        -type f \
        -regextype posix-awk \
        -regex '.*\.(d|h|hpp|c|cc|C|cxx|cpp|idl|java|pl|pm|py|vala)' \
        -print0 | xargs --null cat | grep -v "^$" | wc -l
}

function loc() {
    if [ $# -eq 0 ]; then
        __loc "."
    else
        __loc "$@"
    fi
}

# Output a copy of $1 with duplicates removed
# Note: subsequent copies are removed, otherwise order is preserved.
# 1. the path to remove duplicates from
function remove_duplicates() {
    local original="${1}"
    local result=""
    local IFS=':'
    for item in ${original}; do
        if [ -z "$item" ]; then
            continue
        fi
        local -i found_existing=0
        for existing in ${result}; do
            if [ "${item}" == "${existing}" ]; then
                found_existing=1
                break 1
            fi
        done
        if [ ${found_existing} -eq 0 ]; then
            result="${result:+${result}:}${item}"
        fi
    done
    echo "${result}"
}

# Output a copy of $1 with duplicates removed
# Note: subsequent copies are removed, otherwise order is preserved.
# 1. the path to remove duplicates from
function remove_invalid_dirs() {
    local original="${1}"
    local result=""
    local IFS=':'
    for item in ${original}; do
        if [ -z "$item" ]; then
            continue
        fi
        if [ -d $item ]; then
            result="${result:+${result}:}${item}"
        fi
    done
    echo "${result}"
}

function setup_local() {
    local base=$1

    if [ ! -d "${base}" ]; then
        return
    fi

    if [ -d "${base}/bin" ]; then
        PATH="${base}/bin:${PATH}"
    fi

    if [ -d "${base}/lib" ]; then
        export LD_LIBRARY_PATH="${base}/lib:${LD_LIBRARY_PATH}"

        if [ -d "${base}/lib/pkgconfig" ]; then
            export PKG_CONFIG_PATH="${base}/lib/pkgconfig:${PKG_CONFIG_PATH}"
        fi
    fi

    if [ -d "${base}/lib64" ]; then
        export LD_LIBRARY_PATH="${base}/lib64:${LD_LIBRARY_PATH}"
    fi

    if [ -d "${base}/python2.7/site-packages" ]; then
        export PYTHONPATH="${base}/python2.7/site-packages:$PYTHONPATH"
    fi
}

GIT_PS1_SHOWDIRTYSTATE="yes"
#GIT_PS1_SHOWSTASHSTATE="yes"
GIT_PS1_SHOWUNTRACKEDFILES="yes"

FG=32
if [ -r /etc/bash_completion.d/git-prompt ]; then
    PS1='\n\[\033[0;'$FG'm\]\u@\h: \[\033[1;33m\]\w\[\033[1;34m\]$(__git_ps1 " (%s)")\[\033[0m\]\n$ '
else
    PS1='\n\[\033[0;'$FG'm\]\u@\h: \[\033[1;33m\]\w\[\033[1;34m\]\n\[\033[0m\]$ '
fi
unset FG
PS2="\\ "

PATH=$(remove_duplicates ${PATH})
PATH=$(remove_invalid_dirs ${PATH})
LD_LIBRARY_PATH=$(remove_duplicates ${LD_LIBRARY_PATH})
LD_LIBRARY_PATH=$(remove_invalid_dirs ${LD_LIBRARY_PATH})

ulimit -c unlimited

# Do machine specific things at some point
