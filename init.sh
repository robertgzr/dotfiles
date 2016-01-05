#!/usr/bin/env zsh

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

function setup_gogitparser
{
    echo "[ZSH] Build go-gitparser"
    # build go-gitparser
    cd "$DOT_DIR/zsh/modules/info-functions/go-gitparser"
    eval "go build"
}

function setup_golang_linux
{
    echo "[GOLANG] Download"
    cd /tmp
    curl -O "https://storage.googleapis.com/golang/go$golang_version.linux-amd64.tar.gz"
    echo "[GOLANG] Install"
    tar -C /usr/local -xzf "go$golang_version.linux-amd64.tar.gz"
}

function setup_iosevka
{
    echo "[FONT] Downloading Iosevka $iosevka_version"
    mkdir "/tmp/iosevka$iosevka_version" && cd "/tmp/iosevka$iosevka_version"

    curl -O "https://github.com/be5invis/Iosevka/releases/download/v$iosevka_version/iosevka-$iosevka_version.tar.bz2"
    curl -O "https://github.com/be5invis/Iosevka/releases/download/v$iosevka_version/iosevka-slab-$iosevka_version.tar.bz2"

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

function setup_vim
{
    echo "[VIM] Setup"
    ln -sfv $DOT_DIR/vim $HOME/.vim
    ln -sfv $DOT_DIR/vim/vimrc $HOME/.vimrc
}

function setup_karabiner
{
    echo "[OSX] Karabiner mods"
    # include karabiner-configuration into $HOME/Library/Application Support/Karabiner/private.xml
    [ ! -d "$HOME/Library/Application Support/Karabiner" ] && echo "Can't find Karabiner Config directory. Is Karabiner installed?"
        return 1
    if [ ! -f "$HOME/Library/Application Support/Karabiner/private.xml" ]; then
        touch "$HOME/Library/Application Support/Karabiner/private.xml"
        cat > "$HOME/Library/Application Support/Karabiner/private.xml" <<EOF
<?xml version="1.0"?>
<root>
    <include path="$DOT_DIR/osx/karabiner/private.xml" />
</root>
EOF
    else
        echo "Has Karabiner config"
    fi
}

function setup_ff_userchrome
{
    echo "[OSX] Firefix userChrome mod"
    if [ ! -d "$HOME/Library/Application Support/Firefox/Profiles" ]; then
        echo "Can't find FF profile folder at ~/Library/Application Support/Firefox/Profiles/"
        return 1
    else
        open -a Finder "$HOME/Library/Application Support/Firefox/Profiles"
    fi
}

function setup_osx_system
{
    echo "[OSX] Set system defaults"
    zsh "$DOT_DIR/osx/defaults.sh"
    echo "[OSX] Configure dock"
    zsh "$DOT_DIR/osx/dock.sh"
}

function setup_sublimetext
{
    echo "[ST3] Move preferences into place"
    # ~/Library/Application Support/Sublime Text 3/Packages/User/
    ln -sfv "$DOT_DIR/sublimetext/Preferences.sublime-settings" "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"
    ln -sfv "$DOT_DIR/sublimetext/Package Control.sublime-settings" "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Package Control.sublime-settings"
}

function run
{
    echo "Hey, $you (on $arch)"

    echo ">>> Update dotfile repository"
    echo ">>> Load git submodules"
    # update_dotfiles
    setup_iosevka
    setup_zsh
    setup_config
    setup_git
    setup_vim

    if [[ "$arch" = "Darwin" ]]; then
        echo ">>> Start OSX specific actions"
        setup_homebrew
        setup_ff_userchrome
        setup_karabiner
        setup_osx_system
        setup_sublimetext
    # # #
    elif [[ "$arch" = "Linux" ]]; then
        echo ">>> Start Linux specific actions"
        setup_golang_linux
        # setup linuxbrew for getting devel tools?
    fi
    setup_gogitparser
}

function test
{
    echo "Hey, $you (on $arch)"
    declare -i compl=0
    # test zsh config
    if [ -f "$ZDOTDIR/.zshrc" ]; then
        print -P "Has %F{green}.zshrc%f" && compl+=1
    else
        print -P "%F{red}! no .zshrc"
    fi
    if [ -f "$HOME/.zshenv" ]; then
        print -P "Has %F{green}~/.zshenv%f" && compl+=1
    else
        print -P "%F{red}! no .zshenv %f"
    fi
    # check if config was symlinked
    if [ -d "$HOME/.config" ]; then
        print -P "Has %F{green}~/.config%f" && compl+=1
    else
        print -P "%F{red}! no ~/.config %f"
    fi
    # test git config
    if [ -f "$HOME/.gitconfig" ]; then
        print -P "Has %F{green}.gitconfig%f" && compl+=1
    else
        print -P "%F{red}! no .gitconfig %f"
    fi
    if [ -f "$HOME/.gitignore_global" ]; then
        print -P "Has %F{green}.gitignore_global%f" && compl+=1
    else
        print -P "%F{red}! no global gitignore %f"
    fi
    # OSX: brew?
    if [ "$arch" = "Darwin" ] && [ -f "/usr/local/bin/brew" ]; then
        print -P "Has %F{green}Homebrew%f" && compl+=1
    else
        print -P "%F{red}! either no OSX or no homebrew %f"
    fi
    # OSX: font?
    if [ "$arch" = "Darwin" ] && [ -f "$HOME/Library/Fonts/iosevka-regular.ttf" ]; then
        print -P "Has %F{green}Iosevka%f" && compl+=1
    else
        print -P "%F{red}! no iosevka %f"
    fi
    # gitparser?
    if [ ! -z "$($ZDOTDIR/modules/info-functions/go-gitparser/go-gitparser)" ]; then
        print -P "%F{green}go-gitparser%f works" && compl+=1
    else
        print -P "%F{red}! can't evaluate go-gitparser %f"
    fi
    # karabiner config?
    if [ -f "$HOME/Library/Application Support/Karabiner/private.xml" ]; then
        print -P "Has %F{green}Karabiner%f custom keybindings" && compl+=1
    else
        print -P "%F{red}! no karabiner config%f"
    fi

    declare -i all=9
    print -P "%B%K{blue}>>> $compl/$all - $(( ($compl/$all)*100 ))%% complete%k"
}

[ "$#" = 0 ] && print -P "Usage: init.sh [test] [all]"
[ "$1" = "all" ] && run
[ "$1" = "test" ] && test
# add option to run individual commands