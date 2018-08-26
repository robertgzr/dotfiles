#!/usr/bin/env zsh

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

function mcd {
    mkdir $1 && cd $1
}

function abspath() {
    # $1 : relative filename
    if [ -d "$(dirname "$1")" ]; then
        echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
    fi
}

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

function mpva() {
    local chars=" █▄  "
    mpv --no-video --term-osd=force --term-osd-bar=yes --term-osd-bar-chars=$chars --term-playing-msg='> ${media-title}' --input-media-keys=yes --ytdl-format=bestaudio $@
}

# mpvp script to start mpv with content of the clipboard
function mpvp
{
    local usage="""mpvp [-a] [mpv options]\n
    -a\tplays only audio\n
    (takes additional mpv cli flags)
    """
    local profile="--profile=cacheplus"
    local paste=${"$(pbpaste)"}
    # eval paste before starting
    if [[ ! $paste =~ '^(http:|https:|rtmp:|/)' ]]; then 
        echo "it seems '$paste' is not a URL!"
        return
    fi
    # mpvp main
    if [[ $1 = "-a" ]]; then
        echo "running: mpva ${@/-a/} $profile $paste";
        mpva "$profile" "${@/-a/}" "$paste";
    elif [[ $1 = "-h" ]]; then
            echo "$usage";
    else
        echo "running: mpv $@ $profile $paste"
        mpv "$profile" "$@" "$paste"
    fi
}

function wego {
    local loc=$1
    if -z $loc; then loc="Berlin"; fi
    curl -s "wttr.in/${loc}" | head -7
}

function na {
    local CAT_PROG=(less)
    local LS_PROG=(ls)

    local o=$1
    if [[ -f $o ]]; then $CAT_PROG[@] $o; fi;
    if [[ -d $o ]]; then $LS_PROG[@] $o; fi;
}

function gofat {
    if [[ ! -f $(which go) ]]; then echo "Go not installed";return; fi

    eval "$(go build -work -a "${1}" 2>&1)" && find "${WORK}" -type f -name "*.a" -print0 | xargs --null -I{} du -hxs "{}" | sort -rh | sed -e s:"$WORK"/::g
}

function gocd {
    if [[ ! -d ${GOPATH} ]]; then echo "GOPATH not found";return; fi

    local gopath="$(echo ${GOPATH} | sed -e 's/\//\\\//g')\/src\/";
    cd "$(echo $gopath | sed -e 's/\\//g')$(fd --follow \
        --type d \
        --threads 4 \
        --color never \
        --exclude 'vendor/*' \
        --exclude 'v/*' \
        '' ${GOPATH}/src \
        2>/dev/null \
        | sed -e s/${gopath}// | \
        fzf \
        --height=50% \
        --exit-0 \
        --cycle \
        -1 \
        -q "$1")";
    # zle reset-prompt
}
