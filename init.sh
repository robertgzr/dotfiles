#!/usr/bin/env bash

export DOT_DIR

DOT_DIR="$HOME/.dotfiles"

arch=`uname`
you=`whoami`

iosevka_version="1.2.0"
golang_version="1.5.2"

function update_dotfiles
{
    # update dotfiles
    [ -d "$DOT_DIR/.git" ] && git --work-tree="$DOT_DIR" --git-dir="$DOT_DIR/.git" pull origin master
    # update submodules
    git submodule update --init --recursive
}

function setup_git
{
    echo "[CONFIG] Git global configuration"
    # git-configs
    ln -sfv "$DOT_DIR/git/gitconfig" ~/.gitconfig
    ln -sfv "$DOT_DIR/git/gitignore_global" ~/.gitignore_global
}

function setup_homebrew
{
    echo "[BREW] Install"
    eval "$DOT_DIR/install/brew/install"
    echo "[BREW] Update"
    brew update
    echo "[BREW] Upgrade"
    brew upgrade
    # eval Brewfile
    echo "[BREW] Evaluate Brewfile"
    brew bundle
}

function setup_zsh
{
    echo "[ZSH] Link .zshrc"
    # bacause I made $DOT_DIR/zsh my ZDOTDIR
    ln -sfv "$DOT_DIR/zsh/zshrc" "$DOT_DIR/zsh/.zshrc"

    echo "[ZSH] Link .zshenv and .fasd"
    ln -sfv "$DOT_DIR/zsh/modules/fasd/fasd.rc" ~/.fasdrc
    ln -sfv "$DOT_DIR/zsh/zshenv" ~/.zshenv
}

function setup_config
{
    echo "[CONFIG] Link .config directory into $HOME"
    # .config dir -> home
    ln -sfv "$DOT_DIR/config" ~/.config
}

function setup_go-gitparser
{
    echo "[ZSH] Build go-gitparser"
    # build go-gitparser
    cd "$DOT_DIR/zsh/modules/info-functions/go-gitparser"
    go build
}

function setup_golang_linux
{
    echo "[GOLANG] Download"
    cd /tmp
    wget "https://storage.googleapis.com/golang/go$golang_version.linux-amd64.tar.gz"
    echo "[GOLANG] Install"
    tar -C /usr/local -xzf "go$golang_version.linux-amd64.tar.gz"
}

function setup_iosevka
{
    echo "[FONT] Downloading Iosevka $iosevka_version"
    mkdir "/tmp/iosevka$iosevka_version" && cd "/tmp/iosevka$iosevka_version"

    wget "https://github.com/be5invis/Iosevka/releases/download/v$iosevka_version/iosevka-$iosevka_version.tar.bz2"
    wget "https://github.com/be5invis/Iosevka/releases/download/v$iosevka_version/iosevka-slab-$iosevka_version.tar.bz2"

    echo "[FONT] Installing Iosevka"
    if [[ "$arch" = "Darwin" ]]; then
    # # #
        tar -C ~/Library/Fonts -xzf "iosevka-slab-$iosevka_version.tar.bz2"
        tar -C ~/Library/Fonts -xzf "iosevka-$iosevka_version.tar.bz2"
    # # #
    elif [[ "$arch" = "Linux" ]]; then
    # # #
        tar -C /usr/local/share/fonts/truetype -xzf "iosevka-slab-$iosevka_version.tar.bz2"
        tar -C /usr/local/share/fonts/truetype -xzf "iosevka-$iosevka_version.tar.bz2"
    fi
}

function setup_karabiner
{
    echo "not yet"
    # include karabiner-configuration into ~/Library/Application Support/Karabiner/private.xml
    #
    # <?xml version="1.0"?>
    # <root>
    #     <include path="$DOT_DIR/osx/karabiner/private.xml" />
    # </root>
}

function setup_ff_userchrome
{
    echo "not yet"
    # move FF userChrome into profile dir
}

function run
{
    echo "Hey, $you ($arch)"

    echo ">>> Update dotfile repository"
    echo ">>> Load git submodules"
    update_dotfiles
    setup_iosevka
    setup_zsh
    setup_config
    setup_git

    if [[ "$arch" = "Darwin" ]]; then
        echo ">>> Start OSX specific actions"
        setup_homebrew
        echo "[OSX] Firefix userChrome mod"
        setup_ff_userchrome
        echo "[OSX] Karabiner mods"
        setup_karabiner
        # echo "[OSX] Set system defaults"
        # defaults
        # sublime text config
    # # #
    elif [[ "$arch" = "Linux" ]]; then
        echo ">>> Start Linux specific actions"
        setup_golang_linux
        # setup linuxbrew for getting devel tools?
    fi
    setup_go-gitparser
}

function test
{
    echo "Hey, $you ($arch)"
    declare -i compl=0
    [ -f "$ZDOTDIR/.zshrc" ] && echo "Has .zshrc" && compl+=1
    [ -f "$HOME/.zshenv" ] && echo "Has ~/.zshenv" && compl+=1
    [ -d "$HOME/.config" ] && echo "Has ~/.config" && compl+=1
    [ -f "$HOME/.gitconfig" ] && echo "Has .gitconfig" && compl+=1
    [ -f "$HOME/.gitignore_global" ] && echo "Has .gitignore_global" && compl+=1
    [ "$arch" = "Darwin" ] && [ -f "/usr/local/bin/brew" ] && echo "Has Homebrew" && compl+=1
    [ "$arch" = "Darwin" ] && [ -f "$HOME/Library/Fonts/iosevka-regular.ttf" ] && echo "Has Iosevka" && compl+=1
    [ -f "$DOT_DIR/zsh/modules/info-functions/go-gitparser" ] && [ ! -z "$($DOT_DIR/zsh/modules/info-functions/go-gitparser)" ] && echo "go-gitparser works" && compl+=1
    echo ">>> $compl/8 - $(( (100/8)*$compl ))% complete"
}

[ "$#" = 0 ] && run
[ "$1" = "test" ] && test
[ "$1" = "help" ] && echo "Usage: init.sh [test] [help]"