#!/usr/bin/env zsh
# ==== FUNCTIONS

# load seperate mpvp script
autoload -Uz mpvp
autoload -Uz schreibmit
autoload -Uz wego
autoload -Uz gocd
autoload -Uz gofat
autoload -Uz lockmac
autoload -Uz na

# refresh ZSH configuration
function source-zsh {
    source "$ZDOTDIR/zshrc"
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
function fcd {
    local file
    local dir
    file=$(fzf +m -0 -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# jj using fzf
function fjj {
    local dir
    dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "$dir" || return 1
}

# open using fzf
function fopen {
    local file
    local dir
    file=$(fzf +m -0 -q "$1") && open "$file"
}

function fmpv {
    local file
    file=$(fzf +m -0 -q "mkv$ | mp4$ | 3gp$ $1") && mpv "$file"
}

function fzf-fasd-vim {
    local file
    file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && $EDITOR "$file" || return 1
}

# set AppleShowAllFiles to TRUE or FALSE
function findershowall() {
    defaults write com.apple.finder AppleShowAllFiles $1;
    killall Finder;
    echo 'set AppleShowAllFiles to '$1;
}

function encfs-mount() {
    echo "$(abspath $1)" "->" $2
    encfs --idle=30 "$(abspath $1)" $2 && echo "** success! **"
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
    fd --type file --hidden --no-ignore | wc -l | awk '{print $1}'
}
