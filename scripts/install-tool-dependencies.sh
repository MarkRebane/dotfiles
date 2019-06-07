#!/usr/bin/env bash
set -e

sudo apt -y install libevent-dev libutempter-dev \
autoconf automake pkg-config bison \
libncurses5-dev libgnome2-dev libgnomeui-dev \
libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev \
libxpm-dev libxt-dev python python-dev python3 python3-dev ruby-dev lua5.3 \
liblua5.3-dev libperl-dev git libgpm-dev gpm cmake python-pip curl \
bash-completion git-extras


#pip install --user powerline-status

# Create Symlinks if lua 5.3 isn't detected
# TODO detect 5.3
sudo ln -s /usr/include/lua5.3 /usr/local/include/lua
sudo ln -s /usr/lib/x86_64-linux-gnu/liblua5.3.so /usr/local/lib/liblua.so
sudo ln -s /usr/bin/lua5.3 /usr/local/bin/lua
