#!/bin/sh
set -e

sudo apt -y update

# Basic (tmux/vim) dependencies
sudo apt -y install                                                            \
    autoconf automake bash-completion bison curl cmake                         \
    pkg-config git git-extras git-lfs ninja-build                              \
    python3 python3-dev python3-pip python3-venv                               \
    libevent-dev libutempter-dev libncurses5-dev                               \
    libgtk2.0-dev libatk1.0-dev libcairo2-dev libx11-dev                       \
    libxpm-dev libxt-dev libperl-dev gpm libgpm-dev lua5.3 liblua5.3-dev       \
    ruby-dev gettext unzip

# Clang dependencies
sudo apt -y install                                                            \
    libz3-dev libxml2-dev libocaml-compiler-libs-ocaml-dev libedit-dev         \
    liblzma-dev swig

# Additional tools
sudo apt -y install                                                            \
    doxygen fzf ripgrep tig urlview xdg-utils

# Python 3 auto-formatter.
# pip3 install --user black

# Powerline status bar used by the Vim configuration.
# pip3 install --user powerline-status
