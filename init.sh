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

# build gitparser:
# cd "$DOT_DIR/zsh/modules/info-functions/cgitparser"

# .config dir -> home
ln -sfv "$DOT_DIR/config" ~/.config

# git-configs
ln -sfv "$DOT_DIR/git/gitconfig" ~/.gitconfig
ln -sfv "$DOT_DIR/git/gitignore_global" ~/.gitignore_global


# install brew
eval "$DOT_DIR/install/brew/install"
brew update
brew upgrade

# eval Brewfile

# move FF userChrome into profile dir

# include karabiner-configuration into ~/Library/Application Support/Karabiner/private.xml
#
# <?xml version="1.0"?>
# <root>
#     <include path="$DOT_DIR/osx/karabiner/private.xml" />
# </root>

# Test what you've done

