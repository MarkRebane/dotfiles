#!/usr/bin/env bash
set -e

sudo apt -y update
sudo apt -y install autoconf automake bash-completion bison curl cmake         \
pkg-config git git-extras                                                      \
python3 python3-dev python3-pip python3-venv                                   \
libevent-dev libutempter-dev libncurses5-dev libgnome2-dev libgnomeui-dev      \
libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev          \
libxpm-dev libxt-dev libperl-dev gpm libgpm-dev lua5.3 liblua5.3-dev           \
ruby-dev

# Python 3.6+ auto-formatter.
# pip3 install --user black

# Powerline status bar used by the Vim configuration.
pip3 install --user powerline-status

# Create Symlinks if lua 5.3 isn't detected
# TODO detect 5.3
sudo ln -s /usr/include/lua5.3 /usr/local/include/lua
sudo ln -s /usr/lib/x86_64-linux-gnu/liblua5.3.so /usr/local/lib/liblua.so
sudo ln -s /usr/bin/lua5.3 /usr/local/bin/lua
