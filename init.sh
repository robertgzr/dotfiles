#!/usr/bin/env zsh

export DOT_DIR
DOT_DIR="$HOME/.dotfiles"

arch=`uname`
you=`whoami`

golang_version="1.6.1"

function update_dotfiles()
{
    # update dotfiles
    [ -d "$DOT_DIR/.git" ] && git --work-tree="$DOT_DIR" --git-dir="$DOT_DIR/.git" pull origin master
    # update submodules
    git submodule update --init --recursive
}

function setup_git()
{
    echo "[CONFIG] Git global configuration"
    # git-configs
    ln -sfv "$DOT_DIR/git/gitconfig" ~/.gitconfig
    ln -sfv "$DOT_DIR/git/gitignore_global" ~/.gitignore_global
    git config --global core.excludesfile ~/.gitignore_global
}

function setup_homebrew()
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
    echo "[BREW] Finished setting up homebrew\n"
}

function setup_zsh()
{
    echo "[ZSH] Link .zshrc"
    # because I made $DOT_DIR/zsh my ZDOTDIR
    ln -sfv "$DOT_DIR/zsh/zshrc" "$DOT_DIR/zsh/.zshrc"

    echo "[ZSH] Link .zshenv and .fasd"
    ln -sfv "$DOT_DIR/zsh/modules/fasd/fasd.rc" ~/.fasdrc
    ln -sfv "$DOT_DIR/zsh/zshenv" ~/.zshenv

    # pull submodules
    # echo "[ZSH] Pull zsh submodules"
    # git submodule foreach git pull origin master 1>/dev/null
    # git submodule update --init --recursive

    echo "[ZSH] Finished setting up zsh\n"
}

function setup_config()
{
    echo "[CONFIG] Link .config directory into $HOME"
    # .config dir -> home
    ln -sfv "$DOT_DIR/config" ~/.config
    echo "[CONFIG] Finished setting up .config dir\n"
}

function setup_gogitparser()
{
    echo "[ZSH] Build go-gitparser"
    # build go-gitparser
    cd "$DOT_DIR/zsh/modules/info-functions/go-gitparser"
    eval "go build"
    echo "[ZSH] Built go-gitparser\n"
}

function setup_golang_linux()
{
    echo "[GOLANG] Download"
    cd /tmp
    curl -O "https://storage.googleapis.com/golang/go$golang_version.linux-amd64.tar.gz"
    echo "[GOLANG] Install"
    tar -C /usr/local -xzf "go$golang_version.linux-amd64.tar.gz"
}

function setup_iosevka()
{
    echo "[FONT] Downloading Iosevka $iosevka_version"
    iosevka_version = "$(curl https://github.com/be5invis/iosevka/releases/latest -s | awk '{i=match($5, "/v"); print substr($5, i+2, 5)}')"
    echo "[FONT] Most recent version of Iosevka: $iosevka_version"

    mkdir "/tmp/iosevka$iosevka_version" && cd "/tmp/iosevka$iosevka_version"

    curl -O "https://github.com/be5invis/Iosevka/releases/download/v$iosevka_version/01.iosevka-$iosevka_version.zip"
    curl -O "https://github.com/be5invis/Iosevka/releases/download/v$iosevka_version/04.iosevka-slab-$iosevka_version.zip"

    echo "[FONT] Installing Iosevka"
    if [[ "$arch" = "Darwin" ]]; then
    ###
        unzip -d /Library/Fonts/Iosevka "01.iosevka-$iosevka_version.zip"
        unzip -d /Library/Fonts/Iosevka-Slab "04.iosevka-slab-$iosevka_version.zip"
    ###
    elif [[ "$arch" = "Linux" ]]; then
    ###
        unzip -d /usr/local/share/fonts/truetype/iosevka "01.iosevka-$iosevka_version.zip"
        unzip -d /usr/local/share/fonts/truetype/iosevka-slab "04.iosevka-slab-$iosevka_version.zip"
    ###
    fi

    echo "[FONT] Installed Iosevka monospace font\n"
}

function setup_vim()
{
    echo "[VIM] Setup"
    ln -sfv $DOT_DIR/vim $HOME/.vim
    ln -sfv $DOT_DIR/vim/vimrc $HOME/.vimrc
    # make centralized folders
    mkdir -pv $DOT_DIR/vim/backups
    mkdir -pv $DOT_DIR/vim/swaps
    mkdir -pv $DOT_DIR/vim/undo

    echo "[VIM] Initial PlugUpdate"
    $(which vim) +PlugUpdate +:q! +:q! &>/dev/null

    if [[ "$arch" = "Darwin" ]]; then
        echo "[VIM] Linking config for NeoVim"
        ln -sfv $DOT_DIR/vim $DOT_DIR/config/nvim
        ln -sfv $DOT_DIR/vim/vimrc $DOT_DIR/config/nvim/init.vim
    fi
    echo "[VIM] Finished setting up vim\n"
}

function setup_karabiner()
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

function setup_ff_userchrome()
{
    echo "[OSX] Firefix userChrome mod"
    if [ ! -d "$HOME/Library/Application Support/Firefox/Profiles" ]; then
        echo "Can't find FF profile folder at ~/Library/Application Support/Firefox/Profiles/"
        return 1
    else
        open -a Finder "$HOME/Library/Application Support/Firefox/Profiles"
    fi
}

function setup_osx_system()
{
    echo "[OSX] Set system defaults"
    zsh "$DOT_DIR/osx/defaults.sh"
    echo "[OSX] Configure dock"
    zsh "$DOT_DIR/osx/dock.sh"
}

function setup_sublimetext()
{
    echo "[ST3] Move preferences into place"
    # ~/Library/Application Support/Sublime Text 3/Packages/User/
    local rem=$(pwd)
    cd $DOT_DIR/sublimetext/User/Projects
    for v in *; do
        b64 $v -D; rm -fv $v;
    done
    cd $rem
    cp -v "$DOT_DIR/sublimetext/User" "$HOME/Library/Application Support/Sublime Text 3/Packages/User"
}

function test()
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
    # vim?
    if [ -f "$HOME/.vimrc" ]; then
        print -P "Has %F{green}vimrc%f" && compl+=1
    else
        print -P "%F{red}! no $HOME/.vimrc %f"
    fi
    # OSX: nvim?
    if [ "$arch" = "Darwin" ] && [ -f "$HOME/.config/nvim/init.vim" ]; then
        print -P "Has %F{green}NeoVim - init.vim%f" && compl+=1
    else
        print -P "%F{red}! either no OSX or no init.vim for NeoVim%f"
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
    if [ "$arch" = "Darwin" ] && [ -f "/Library/Fonts/Iosevka/iosevka-regular.ttf" ]; then
        print -P "Has %F{green}Iosevka%f" && compl+=1
    else
        print -P "%F{red}! no iosevka %f"
    fi
    # karabiner config?
    if [ -f "$HOME/Library/Application Support/Karabiner/private.xml" ]; then
        print -P "Has %F{green}Karabiner%f custom keybindings" && compl+=1
    else
        print -P "%F{red}! no karabiner config%f"
    fi
    # gitparser?
    if [ ! -z "$($ZDOTDIR/modules/info-functions/go-gitparser/go-gitparser)" ]; then
        print -P "%F{green}go-gitparser%f works" && compl+=1
    else
        print -P "%F{red}! can't evaluate go-gitparser %f"
    fi

    declare -i all=11
    print -P "%B%K{blue}>>> $compl/$all complete%k" #- $(( ($compl/$all)*100 ))%% complete%k"
}

function run()
{
    echo "Hi, $you (on $arch)"

    echo ">>> Update dotfile repository"
    echo ">>> Load git submodules"
    update_dotfiles
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
        # setup_golang_linux
        # setup linuxbrew for getting devel tools?
    fi
    setup_gogitparser
}

function action()
{
    case $1 in
        "zsh")
            setup_zsh ;;
        "vim")
            setup_vim ;;
        "sublimetext")
            setup_sublimetext ;;
        "homebrew")
            setup_homebrew ;;
        "config")
            setup_config ;;
        "font")
            setup_iosevka ;;
        "osx-system")
            setup_osx_system ;;
        "karabiner")
            setup_karabiner ;;
        "firefox")
            setup_ff_userchrome ;;
        "git")
            setup_git ;;
        "go-gitparser")
            setup_gogitparser ;;
        *)
            echo $usage ;;
    esac
}

#
# script control
#

usage="Usage: init.sh [test] [all] [do <action>]\n\n actions: git,homebrew,vim,zsh,config,karabiner,sublimetext,osx-system,go-gitparser,firefox,font\n"
case $1 in
    "all")
        run ;;
    "test")
        test ;;
    "do")
        action $2 ;;
    *)
        echo $usage
esac