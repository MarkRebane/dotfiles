# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

## { Basics }-------------------------------------------------------------------

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTFILESIZE= # Infinite history
HISTSIZE=     # Infinite history

# cd into directories by typing only the directory name
shopt -s autocd

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# append to the history file, don't overwrite it
shopt -s histappend

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

ulimit -c unlimited

# Disable Software Flow Control
stty -ixon

## { Colours }------------------------------------------------------------------

# uncomment for a coloured prompt, if the terminal has the capability
#force_colour_prompt=yes

# decide if we're going to try using colours
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

if [ -n "${colour_prompt}" ]; then
    no_colour='\033[0m'
    # Palette entires 0-7
    plt00='\033[0;30m' # Black
    plt01='\033[0;31m' # Red
    plt02='\033[0;32m' # Green
    plt03='\033[0;33m' # Brown
    plt04='\033[0;34m' # Blue
    plt05='\033[0;35m' # Purple
    plt06='\033[0;36m' # Cyan
    plt07='\033[0;37m' # Light Gray
    # Palette entires 8-15
    plt08='\033[1;30m' # Dark Gray
    plt09='\033[1;31m' # Light Red
    plt10='\033[1;32m' # Light Green
    plt11='\033[1;33m' # Yellow
    plt12='\033[1;34m' # Light Blue
    plt13='\033[1;35m' # Light Purple
    plt14='\033[1;36m' # Light Cyan
    plt15='\033[1;37m' # White
else
    no_colour=
    # Palette entires 0-7
    plt00= # Black
    plt01= # Red
    plt02= # Green
    plt03= # Brown
    plt04= # Blue
    plt05= # Purple
    plt06= # Cyan
    plt07= # Light Gray
    # Palette entires 8-15
    plt08= # Dark Gray
    plt09= # Light Red
    plt10= # Light Green
    plt11= # Yellow
    plt12= # Light Blue
    plt13= # Light Purple
    plt14= # Light Cyan
    plt15= # White
fi
unset colour_prompt force_colour_prompt

## { Aliases }------------------------------------------------------------------

# enable colour support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -hNF --color=auto --group-directories-first --time-style=iso'
    alias grep='grep --color=auto'
    alias egrep='egrep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias ccat='highlight --out-format=ansi'
    alias less='less -R'
    alias tmux='tmux -2'

    # coloured GCC warnings and errors
    export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

    # GREP_COLORS
    #  $ man grep
    # Generate a colours string at: https://dom.hastin.gs/files/grep-colors/
    export GREP_COLORS='ms=01;33:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36';

    # Set colours for less.
    # https://wiki.archlinux.org/index.php/Color_output_in_console#less
    export LESS_TERMCAP_mb=$'\E[1;31m' # begin bold
    export LESS_TERMCAP_md=$'\E[1;36m' # begin blink
    export LESS_TERMCAP_me=$'\E[0m'    # reset bold/blink
    export LESS_TERMCAP_so=$'\E[1;33m' # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'    # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m' # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'    # reset underline
    # Colour themes for LS_COLORS: https://github.com/sharkdp/vivid
fi

alias ll='ls -al'
alias mkdir='mkdir -p'
alias vi='vim'

alias reload='bind -f ~/.inputrc; source ~/.bashrc'

# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f $HOME/.bash_aliases ]; then
    source $HOME/.bash_aliases
fi

## { MotD }---------------------------------------------------------------------

function print_motd() {
    echo -e "${plt02}This is BASH ${plt03}${BASH_VERSION%.*}"                  \
            "${plt02}- DISPLAY on ${plt03}${DISPLAY}"                          \
            "${plt02}- TERM running ${plt03}${TERM}${no_colour}"               \
            "\n${plt02}$(date)${no_colour}"
}

if [[ "${DISPLAY%%:0*}" != "" ]]; then
    user_host_colour=${plt09} # remote machine
else
    user_host_colour=${plt07} # local machine
fi

## { Less }---------------------------------------------------------------------

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
# -F   --quit-if-one-screen
# -i   --ignore-case
# -J   --status-column
# -M   --LONG-PROMPT
# -R   --RAW-CONTROL-CHARS
# -W   --HILITE-UNREAD
# -x4  --tabs=4
# -x   --no-init
# -z-4 --window=4
export LESS='-F -i -J -M -R -W -x4 -X -z-4'
export LESSCHARSET='utf-8'
export PAGER='less -R'

## { Prompt }-------------------------------------------------------------------

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

path_colour=${plt15}
git_colour=${plt12}

GIT_PS1_SHOWDIRTYSTATE="yes"
GIT_PS1_SHOWSTASHSTATE="yes"
GIT_PS1_SHOWUNTRACKEDFILES="yes"
GIT_PS1_SHOWUPSTREAM="verbose name"

# It can be useful to put this in the .git/config of huge repos:
# [bash]
#     showDirtyState     = false
#     showUntrackedFiles = false

function fastprompt() {
    unset PROMPT_COMMAND
    PS1="\[${debian_chroot:+($debian_chroot)}\]"
    case $TERM in
        # If this is an xterm set the title to:
        # user@host:dir$
        xterm* | rxvt* )
            PS1="$PS1\[${user_host_colour}\]\u@\h$\[{no_colour}\]:\[${path_colour}\]\w \$ " ;;
        * )
            # Why are we distinguishing terminals?
            # What can we do with this information?
            PS1="$PS1\u@\h:\w \$ " ;;
    esac
}

function powerprompt() {
    unset PROMPT_COMMAND
    PS1='\[${debian_chroot:+($debian_chroot)}\]'
    case ${TERM} in
        # If this is an xterm set the title to:
        # user@host:#:dir(branch)
        # 00:00.00 $
        xterm* | rxvt* )
            PS1="$PS1\[${user_host_colour}\]\u@\h\[${no_colour}\]:\[${path_colour}\]\w"
            if [ -r /etc/bash_completion.d/git-prompt ]; then
                #source /etc/bash_completion.d/git-prompt
                PS1="$PS1"'\['${git_colour}'\]$(__git_ps1 "(%s)")\['${no_colour}'\]'
            fi ;;
        * )
            # Why are we distinguishing terminals?
            # What can we do with this information?
            PS1="$PS1\u@\h:\w " ;;
    esac
    PS1="$PS1"'\n\$ '
}

# Shell Prompt
powerprompt
PS2="\\ "

## { fzf }----------------------------------------------------------------------

# Setup fzf: $ apt install fzf
# Auto-completion and key bindings
[[ $- == *i* ]]                                                                \
    && source "${HOME}/.fzf/shell/completion.bash"                             \
    && source "${HOME}/.fzf/shell/key-bindings.bash"                           \
    || echo "Warning: Failed to initialise fzf"

## { Functions }----------------------------------------------------------------

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

# Print all 16 colours
function rainbow16() {
    for i in $(seq -f "%02g" 0 7); do
        local palette=plt${i}
        printf "{${!palette}${palette}${no_colour}}, "
    done
    printf "\n"
    for i in $(seq -f "%02g" 8 15); do
        local palette=plt${i}
        printf "{${!palette}${palette}${no_colour}}, "
    done
    printf "${no_colour}{no_colour}\n"
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
    local base=${1}

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

    if [ -d "${base}/python3.8/site-packages" ]; then
        export PYTHONPATH="${base}/python3.8/site-packages:${PYTHONPATH}"
    fi
}

## { Local setup & paths }------------------------------------------------------

setup_local ${HOME}/.local
for file in ${HOME}/.local/*; do
    setup_local ${file}
done

# Load local machine's configuration
localbashrc="${HOME}/.bashrc.local"
if [ -r ${localbashrc} ]; then
    source ${localbashrc}
else
    echo "Warning: ${localbashrc} not found."
fi

PATH=$(remove_duplicates ${PATH})
PATH=$(remove_invalid_dirs ${PATH})
LD_LIBRARY_PATH=$(remove_duplicates ${LD_LIBRARY_PATH})
LD_LIBRARY_PATH=$(remove_invalid_dirs ${LD_LIBRARY_PATH})

print_motd
