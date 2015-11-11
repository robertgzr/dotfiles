#!/usr/bin/env bash

export DOT_DIR

DOT_DIR="$HOME/.dotfiles"

# update dotfiles
[ -d "$DOT_DIR/.git" ] && git --work-tree="$DOT_DIR" --git-dir="$DOT_DIR/.git" pull origin master

# symlinks
ln -sfv "$DOT_DIR/zsh/modules/fasd/fasd.rc" ~/.fasdrc
ln -sfv "$DOT_DIR/zsh/zshenv" ~/.zshenv
# bacause I made $DOT_DIR/zsh my ZDOTDIR
ln -sfv "$DOT_DIR/zsh/zshrc" "$DOT_DIR/zsh/.zshrc"

cd "$DOT_DIR/zsh/modules/info-functions/cgitparser"
# make

# .config git
ln -sfv "$DOT_DIR/config" ~/.config

ln -sfv "$DOT_DIR/git/gitconfig" ~/.gitconfig
ln -sfv "$DOT_DIR/git/gitignore_global" ~/.gitignore_global


# install brew
eval "$DOT_DIR/install/brew/install"
brew update
brew upgrade

# run brew install scripts

# Test what you've done

