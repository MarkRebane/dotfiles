#!/bin/sh

DATE=$(date --rfc-3339='seconds')
DOTFILES_DIR=$(cd "$(dirname "$0")/.." && pwd)
FORCE=${1-}

link_dotfile() {
    src=$1
    dst=$2
    backup=$3
    kind=$4

    case "$kind" in
        file)
            if [ -f "$dst" ] && [ ! -h "$dst" ] ; then
                mv "$dst" "$backup"
            fi
            ;;
        dir)
            if [ -d "$dst" ] && [ ! -h "$dst" ] ; then
                mv "$dst" "$backup"
            fi
            ;;
        *)
            echo "link_dotfile: unknown kind: $kind" >&2
            return 1
            ;;
    esac

    if [ ! -h "$dst" ] || [ "$FORCE" = "--force" ] ; then
        ln -snf "$src" "$dst"
    fi
}

link_dotfile \
    "$DOTFILES_DIR/dot-bash-common.sh" \
    "$HOME/.bash-common.sh" \
    "$HOME/dot-bash-common.sh-$DATE" \
    file

link_dotfile \
    "$DOTFILES_DIR/dot-bashrc" \
    "$HOME/.bashrc" \
    "$HOME/dot-bashrc-$DATE" \
    file

link_dotfile \
    "$DOTFILES_DIR/dot-bash_logout" \
    "$HOME/.bash_logout" \
    "$HOME/dot-bash_logout-$DATE" \
    file

link_dotfile \
    "$DOTFILES_DIR/dot-inputrc" \
    "$HOME/.inputrc" \
    "$HOME/dot-inputrc-$DATE" \
    file

link_dotfile \
    "$DOTFILES_DIR/dot-profile" \
    "$HOME/.profile" \
    "$HOME/dot-profile-$DATE" \
    file

link_dotfile \
    "$DOTFILES_DIR/dot-tmux.conf" \
    "$HOME/.tmux.conf" \
    "$HOME/dot-tmux.conf-$DATE" \
    file

link_dotfile \
    "$DOTFILES_DIR/dot-vimrc" \
    "$HOME/.vimrc" \
    "$HOME/dot-vimrc-$DATE" \
    file

link_dotfile \
    "$DOTFILES_DIR/dot-vim" \
    "$HOME/.vim" \
    "$HOME/dot-vim-$DATE" \
    dir

link_dotfile \
    "$DOTFILES_DIR/dot-config/nvim" \
    "$HOME/.config/nvim" \
    "$HOME/.config/nvim-$DATE" \
    dir
