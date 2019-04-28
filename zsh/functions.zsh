#!/usr/bin/env zsh

# $1 : directory tree to create and cd into
function mcd {
    mkdir -p $1 && cd $1
}

# $1 : relative filename
function abspath() {
    if [ -d "$(dirname "$1")" ]; then
        echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
    fi
}

# $1 : encrypted tree
# $2 : mount point (created if not an existing dir)
function encfs-mount() {
    local drive=$1
    local mntdir=`abspath $2`
    [[ ! -d $mntdir ]] && mkdir -p $mntdir
    echo "$drive" "->" $mntdir
    encfs --idle=30 $drive $mntdir && echo "** success! **"
}

# return the number of files in a directory
# $1 : directory to count (recurses)
function tree-count() {
    fd --type file --hidden --no-ignore '' ${1} | wc -l
}

# nice tui audio player with mpv
# $1 : args to pass to mpv
function mpva() {
    mpv --no-video --term-osd=force --term-osd-bar=yes --term-osd-bar-chars=' █▄  ' --term-playing-msg='> ${media-title}' --input-media-keys=yes --ytdl-format=bestaudio $@
}

# prints wttr.in report
# $1 : location
function wego {
    curl -s "wttr.in/${1:-Berlin}" | head -7
}

# script to inspect /sys, /proc, etc.
# $1 : file/dir
function na {
    local CAT_PROG=${CAT_PROG:-less}
    local LS_PROG=${LS_PROG:-ls -la}

    local o=$1
    file $o
    [[ -d $o ]] && { sudo sh -c "$LS_PROG $o"; return } # directory
    [[ -f $o ]] && { sudo sh -c "read && $CAT_PROG $o"; return } # regular file
    [[ -h $o ]] && { sudo sh -c "$LS_PROG $o"; return } # symlink
    [[ -b $o ]] && { return } # block file
    [[ -c $o ]] && { return } # character file
}

# go to a package in your GOPATH
# $1 : query to start fuzzy finder with
function gocd {
    if [[ ! -d ${GOPATH} ]]; then echo "GOPATH not found";return; fi

    local gopath="$(echo ${GOPATH} | sed -e 's/\//\\\//g')\/src\/";
    local sel="$(fd --follow \
        --type d \
        --threads 4 \
        --color never \
        --exclude 'vendor/*' \
        --exclude 'v/*' \
        '' ${GOPATH}/src \
        2>/dev/null \
        | sed -e s/${gopath}// | \
        sk \
        --height=50% \
        --exit-0 \
        --cycle \
        -1 \
        -q "$1")";
    [[ -z $sel ]] && return
    cd "$(echo $gopath | sed -e 's/\\//g')$sel"
}
