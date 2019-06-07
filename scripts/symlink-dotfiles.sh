#!/usr/bin/env bash
# Run this from the scripts directory.

date=$(date --rfc-3339='seconds')

bashrc="$HOME/.bashrc"
if [ -f ~/.bashrc ] ; then
  mv ~/.bashrc ~/"dot-bashrc-$date"
fi
if [ ! -h ~/.bashrc ] ; then
  ln -s $(readlink -f ../.bashrc) ~/.bashrc
fi

if [ -f ~/.bash_logout ] ; then
  mv ~/.bash_logout ~/"dot-bash_logout-$date"
fi
if [ ! -h ~/.bash_logout ] ; then
  ln -s $(readlink -f ../.bash_logout) ~/.bash_logout
fi

if [ -f ~/.inputrc ] ; then
  mv ~/.inputrc ~/"dot-inputrc-$date"
fi
if [ ! -h ~/.inputrc ] ; then
  ln -s $(readlink -f ../.inputrc) ~/.inputrc
fi

if [ -f ~/.profile ] ; then
  mv ~/.profile ~/"dot-profile-$date"
fi
if [ ! -h ~/.profile ] ; then
  ln -s $(readlink -f ../.profile) ~/.profile
fi

if [ -f ~/.tmux.conf ] ; then
  mv ~/.tmux.conf ~/"dot-tmux.conf-$date"
fi
if [ ! -h ~/.tmux.conf ] ; then
  ln -s $(readlink -f ../.tmux.conf) ~/.tmux.conf
fi

if [ -f ~/.vimrc ] ; then
  mv ~/.vimrc ~/"dot-tmux.conf-$date"
fi
if [ ! -h ~/.vimrc ] ; then
  ln -s $(readlink -f ../.vimrc) ~/.vimrc 
fi

if [ -d ~/.vim ] ; then
  mv ~/.vim ~/"dot-vim-$date"
fi
if [ ! -h ~/.vim ] ; then
  ln -s $(readlink -f ../.vim) ~/.vim
fi
