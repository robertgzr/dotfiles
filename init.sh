#!/usr/bin/env bash

export DOT_DIR

DOT_DIR="$HOME/.dotfiles"

# update dotfiles
[ -d "$DOT_DIR/.git" ] && git --work-tree="$DOT_DIR" --git-dir="$DOT_DIR/.git" pull origin master

# symlinks
ln -sfv "$DOT_DIR/zsh/zsh.rc" ~/.zshrc
ln -sfv "$DOT_DIR/zsh/zlogin.rc" ~/.zlogin

ln -sfv "$DOT_DIR/git/gitconfig" ~/.gitconfig
ln -sfv "$DOT_DIR/git/gitignore_global" ~/.gitignore_global


# install brew
eval "$DOT_DIR/install/brew/install"

# run brew install scripts

# Test what you've done

