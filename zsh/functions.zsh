#!/usr/bin/env zsh
# ==== FUNCTIONS

# load seperate mpvp script
autoload -Uz mpvp

# refresh ZSH configuration
function source-zsh {
    source "$HOME/.zshrc"
}

# Previews files in Quick Look.
# Author:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
function ql {
    if (( $# > 0 )); then
        qlmanage -p "$@" &> /dev/null
    fi
}

# Displays the Mac OS X download history.
# Author:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
function download-history {
    local db
    for db in ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV*; do
        if grep -q 'LSQuarantineEvent' < <(sqlite3 "$db" .tables); then
            sqlite3 "$db" 'SELECT LSQuarantineDataURLString FROM LSQuarantineEvent'
        fi
    done
}

# ==== Load more good stuff:
source $DOT_DIR/zsh/modules/ffmpeg_functions.zsh
source $DOT_DIR/zsh/modules/ze-best-zsh-config_functions.zsh

function mcd {
    mkdir $1 && cd $1
}

function abspath() {
    # $1 : relative filename
    if [ -d "$(dirname "$1")" ]; then
        echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
    fi
}

# == Fuzzy search scripts using fzf

# supercharged locate
function fzl {
    locate $1 | fzf
}

# cd using fzf
function fzcd {
    local file
    local dir
    file=$(fzf +m -0 -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

function fzjj {
    local dir
    dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "$dir" || return 1
}

# open using fzf
function fzopen {
    local file
    local dir
    file=$(fzf +m -0 -q "$1") && open "$file"
}

function fzmpv {
    local file
    file=$(fzf +m -0 -q "mkv$ | mp4$ | 3gp$ $1") && mpv "$file"
}

# full shell power: fzf + fasd
# to open a file in sublime text
function fzsubl {
    local file
    file=$(fzf +m -0 -q "$1") && subl "$file" || return 1
}

function fzss {
    local file
    file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && subl "$file" || return 1
}

# full shell power: fzf + fasd
# to open a file in sublime text
function fzvim {
    local file
    file=$(fzf +m -0 -q "$1") && vim "$file" || return 1
}

function fzvv {
    local file
    file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && vim "$file" || return 1
}

# start firefox with dev-profile
function firefoxcli() {
    $FIREFOX --new-instance -P "dev";
}

# Execute a command in the same directory but in a new tab
# function tcmd() {
#   if [[  $TERM_PROGRAM != iTerm.app ]]; then
#       open -a Terminal
#       return 0
#   fi
#   # First, get the directory for the new tab
#   ThisDirectory=$PWD

#   if [[ $# == 0  ]]; then
#         print "usage: $0 [commands]"
#         return 1
#   fi

#   osascript <<-eof
# eof
# }

# set AppleShowAllFiles to TRUE or FALSE
function findershowall() {
    defaults write com.apple.finder AppleShowAllFiles $1;
    killall Finder;
    echo 'set AppleShowAllFiles to '$1;
}

function encfs-mount() {
    echo "$(abspath $1)" $2
    encfs "$(abspath $1)" $2
}

function archboxctl {
    if [[ "$1" = "start" ]]; then
        VBoxManage startvm Arch --type headless &>/dev/null;
        echo "archbox started."
    elif [[ "$1" = "stop" ]]; then
        VBoxManage controlvm Arch poweroff soft &>/dev/null;
        echo "archbox stopped.";
    elif [[ "$1" = "status" ]]; then
        echo "$(VBoxManage showvminfo Arch | grep 'Guest OS\|State')"
    elif [[ "$1" = "version" ]]; then
        echo "archup 0.1 - Headless start of Arch Virtual Machine";
    else
        echo "usage: archboxctl [start|stop]";
    fi
}

# locate & open
function lopen {
    if [[ $# = 0 ]]; then
        echo "nüscht da."
        return
    fi
    FILE=$1
    FOPEN=$(locate -l 1 $FILE)
    open $FOPEN
}

# encode input file with base64 and also encode filename
function b64() {
    base64 "$2" -i "$1" -o '$(echo "$1" | base64 "$2" -)';
}

# return the number of files in a directory
function tree-count() {
    tree -C $1 | grep -e files$ | awk '{print $3}';
}

# docker gui convenience
function startx() {
    export DISPLAY_MAC=`ifconfig en0 | grep "inet " | cut -d " " -f2`:0
    defaults write org.macosforge.xquartz.X11 nolisten_tcp -boolean false

    if [ -z "$(ps -ef|grep XQuartz|grep -v grep)" ]; then
        open -a XQuartz
    fi

    if [ -z "$(lsof -i :6000)" ]; then
        socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" & &>/dev/null
    fi
    # pid=$!
    # eval $@ &>/dev/null
    # kill $pid &>/dev/null
}
function stopx() {
    pkill socat
}
