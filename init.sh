#!/usr/bin/env zsh

DOT_DIR="$HOME/.dotfiles"
export DOT_DIR

XDG_CONFIG_HOME="$HOME/Library/Application Support"

arch="$(uname)"
you="$(whoami)"

config_apps=( mpv livestreamer youtube-dl bitbar )

function report_status()
{
    print -P "%F{cyan}[$current_func]%f $1"
}
function report_error()
{
    print -P "err: %F{red}$1%f"
}
function report_warning()
{
    print -P "warn: %F{yellow}$1%f"
}
function report_success()
{
    print -P "✔ %F{green}$1%f"
}

function update_dotfiles()
{
    # update dotfiles
    [ -d "$DOT_DIR/.git" ] && git --work-tree="$DOT_DIR" --git-dir="$DOT_DIR/.git" pull origin master
    # update submodules
    git submodule update --init --recursive
}

function setup_git()
{
    local current_func="git"
    report_status "global configuration"
    # git-configs
    ln -sfv "$DOT_DIR/git/gitconfig" ~/.gitconfig
    ln -sfv "$DOT_DIR/git/gitignore_global" ~/.gitignore_global
    git config --global core.excludesfile ~/.gitignore_global
}

function setup_homebrew()
{
    local current_func="brew"
    report_status "install"
    eval "$DOT_DIR/install/brew/install"
    report_status "update"
    brew update
    report_status "upgrade"
    brew upgrade
    # eval Brewfile
    report_status "evaluate Brewfile"
    brew bundle
    report_status "finished setting up homebrew\n"
}

function setup_zsh()
{
    status="zsh"
    report_status $status "Link .zshrc"
    # because I made $DOT_DIR/zsh my ZDOTDIR
    ln -sfv "$DOT_DIR/zsh/zshrc" "$DOT_DIR/zsh/.zshrc"

    report_status $status "Link .zshenv and .fasd"
    ln -sfv "$DOT_DIR/zsh/modules/fasd/fasd.rc" ~/.fasdrc
    ln -sfv "$DOT_DIR/zsh/zshenv" ~/.zshenv

    # pull submodules
    # report_status $status "Pull zsh submodules"
    # git submodule foreach git pull origin master 1>/dev/null
    # git submodule update --init --recursive

    report_status $status "Finished setting up zsh\n"
}

function setup_config()
{
    local current_func="config"
    report_status "set up various application configs"
    # create .config if neccessary
    if [[ ! -d "$XDG_CONFIG_HOME" ]]; then
        report_error "It appears XDG_CONFIG_HOME is not set..."
        return
    fi

    for app in $config_apps; do
        report_status "linking $app"
        ln -sfv "$DOT_DIR/$app" "$XDG_CONFIG_HOME"
    done

    report_status "Finished setting up config dir\n"
}

function setup_gogitparser()
{
    local current_func="zsh"
    report_status "Build go-gitparser"
    # build go-gitparser
    cd "$DOT_DIR/zsh/modules/info-functions/go-gitparser"
    eval "go build"
    report_status "Built go-gitparser\n"
}

function setup_golang_linux()
{
    local current_func="go"
    local golang_version="1.6.1"
    report_status "Download"
    cd /tmp
    curl -O "https://storage.googleapis.com/golang/go$golang_version.linux-amd64.tar.gz"
    report_status "Install"
    tar -C /usr/local -xzf "go$golang_version.linux-amd64.tar.gz"
}

function setup_iosevka()
{
    local current_func="font"
    report_status "Downloading Iosevka $iosevka_version"
    iosevka_version = "$(curl https://github.com/be5invis/iosevka/releases/latest -s | awk '{i=match($5, "/v"); print substr($5, i+2, 5)}')"
    report_status "Most recent version of Iosevka: $iosevka_version"

    mkdir "/tmp/iosevka$iosevka_version" && cd "/tmp/iosevka$iosevka_version"

    curl -O "https://github.com/be5invis/Iosevka/releases/download/v$iosevka_version/01.iosevka-$iosevka_version.zip"
    curl -O "https://github.com/be5invis/Iosevka/releases/download/v$iosevka_version/04.iosevka-slab-$iosevka_version.zip"

    report_status "Installing Iosevka"
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

    report_status "Installed Iosevka monospace font\n"
}

function setup_vim()
{
    local current_func="vim"
    report_status "Setup neovim"
    ln -sfv "$DOT_DIR/vim" "$HOME/.vim"
    ln -sfv "$DOT_DIR/vim" "$XDG_CONFIG_HOME/nvim"
    # make centralized folders
    mkdir -pv "$DOT_DIR/vim/backups"
    mkdir -pv "$DOT_DIR/vim/swaps"
    mkdir -pv "$DOT_DIR/vim/undo"

    report_status "Install VimPlug"
    if [ ! -f "$DOT_DIR/vim/autoload/plug.vim" ]; then
	curl -fLo "$DOT_DIR/vim/autoload/plug.vim" --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim";
    fi

    report_status "Initial PlugUpdate"
    $(which nvim) +PlugUpdate +:q! +:q! &>/dev/null

    report_status "Finished setting up vim\n"
}

function setup_karabiner()
{
    local current_func="osx"
    report_status "Karabiner mods"
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
        report_warning "There is a Karabiner config already"
    fi
}

function setup_ff_userchrome()
{
    local current_func="osx"
    report_status "Firefix userChrome mod"
    if [ ! -d "$HOME/Library/Application Support/Firefox/Profiles" ]; then
        report_warning "Can't find FF profile folder at ~/Library/Application Support/Firefox/Profiles/"
        return 1
    else
        open -a Finder "$HOME/Library/Application Support/Firefox/Profiles"
    fi
}

function setup_osx_system()
{
    local current_func="osx"
    report_status "Set system defaults"
    zsh "$DOT_DIR/osx/defaults.sh"
    report_status "Configure dock"
    zsh "$DOT_DIR/osx/dock.sh"
}

function setup_sublimetext()
{
    local current_func="sublime"
    report_status "Move preferences into place"
    # ~/Library/Application Support/Sublime Text 3/Packages/User/
    local rem=$(pwd)
    cd $DOT_DIR/sublimetext/User/Projects
    for v in *; do
        b64 $v -D; rm -fv $v;
    done
    cd $rem
    cp -v "$DOT_DIR/sublimetext/User" "$HOME/Library/Application Support/Sublime Text 3/Packages/User"
}

function setup_tmux()
{
    local current_func="tmux"
    report_status "link tmux.conf"

    if [ ! -f "$HOME/.tmux.conf" ]; then
        ln -sfv "$DOT_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
    fi
}

function test()
{
    echo "Hey, $you (on $arch)"
    declare -i compl=0
    declare -i want=0
    # test zsh config
    want+=1
    if [ -f "$ZDOTDIR/.zshrc" ]; then
        report_success ".zshrc" && compl+=1
    else
        report_error "missing .zshrc"
    fi
    want+=1
    if [ -f "$HOME/.zshenv" ]; then
        report_success ".zshenv" && compl+=1
    else
        report_error "missing .zshenv"
    fi
    # using nvim full time
    want+=1
    if [ -f "$XDG_CONFIG_HOME/nvim/init.vim" ]; then
        report_success "init.vim (neovim)" && compl+=1
    else
        report_error "no init.vim for neovim"
    fi
    # still need .vim folder
    want+=1
    if [ -d "$HOME/.vim" ]; then
        report_success ".vim directory link" && compl+=1
    else
        report_error "missing .vim dir"
    fi
    # check if config was symlinked
    for app in $config_apps; do
        want+=1
        if [ -d "$XDG_CONFIG_HOME/$app" ]; then
            report_success $app && compl+=1
        else
            report_error "missing $app"
        fi
    done

    # test git config
    want+=1
    if [ -f "$HOME/.gitconfig" ]; then
        report_success ".gitconfig" && compl+=1
    else
        report_error "missing .gitconfig"
    fi
    want+=1
    if [ -f "$HOME/.gitignore_global" ]; then
        report_success ".gitignore_global" && compl+=1
    else
        report_error "missing global gitignore"
    fi
    # OSX: brew?
    want+=1
    if [ "$arch" = "Darwin" ] && [ -f "/usr/local/bin/brew" ]; then
        report_success "homebrew" && compl+=1
    else
        report_error "no OSX or missing homebrew"
    fi
    # OSX: font?
    want+=1
    if [ "$arch" = "Darwin" ] && [ -f "/Library/Fonts/Iosevka/iosevka-regular.ttf" ]; then
        report_success "Iosevka" && compl+=1
    else
        report_warning "missing Iosevka font"
    fi
    # karabiner config?
    want+=1
    if [ -f "$HOME/Library/Application Support/Karabiner/private.xml" ]; then
        report_success "Karabiner (custom keybindings)" && compl+=1
    else
        report_warning "missingkarabiner config"
    fi
    # gitparser?
    want+=1
    if [ ! -f "$ZDOTDIR/modules/info-function/go-gitparser/go-gitparser" ]; then
        report_error "missing go-gitparser";
    else
        if [ ! -z "$($ZDOTDIR/modules/info-functions/go-gitparser/go-gitparser)" ]; then
            report_success "go-gitparser" && compl+=1;
        else
            report_warning "can't evaluate go-gitparser";
        fi
    fi
    # tmux
    want+=1
    if [ ! -f "$HOME/.tmux.conf" ]; then
        report_error "missing tmux.conf"
    else
        report_success "tmux.conf" && compl+=1;
    fi

    print -P "%B%K{blue}>>> $compl/$want complete%k"
}

function run()
{
    local current_func="init"
    echo "Hi, $you (on $arch)"

    report_status "Update dotfile repository"
    report_status "Load git submodules"
    update_dotfiles
    setup_iosevka
    setup_zsh
    setup_config
    setup_git
    setup_vim
    setup_tmux

    if [[ "$arch" = "Darwin" ]]; then
        report_status "Start OSX specific actions"
        setup_homebrew
        # setup_ff_userchrome
        setup_karabiner
        setup_osx_system
        setup_sublimetext
    # # #
    elif [[ "$arch" = "Linux" ]]; then
        report_status "Start Linux specific actions"
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
        "tmux")
            setup_tmux ;;
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
