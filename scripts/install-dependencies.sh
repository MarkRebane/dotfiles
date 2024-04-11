#!/usr/bin/env bash
set -euxo pipefail

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

# Emacs dependencies
sudo apt -y build-dep emacs
sudo apt -y install                                                            \
    build-essential libgtk-3-dev libgnutls28-dev                               \
    libtiff5-dev libgif-dev libjpeg-dev libpng-dev                             \
    libxpm-dev libncurses-dev texinfo                                          \
    libjansson4 libjansson-dev                                                 \
    libgccjit0 libgccjit-10-dev gcc-10 g++-10                                  \
    libmagickcore-dev libmagick++-dev                                          \
    libtree-sitter-dev libwebkit2gtk-4.1-dev mailutils

# Additional tools
sudo apt -y install                                                            \
    doxygen fasd fzf gitk kmag ripgrep tig urlview xdg-utils

