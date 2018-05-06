#!/bin/sh

np_cmus() {
    output="$(cmus-remote -Q 2>/dev/null | awk '{print; print ";"}')"
    status="$(cmus-remote -Q 2>/dev/null | grep 'status' | cut -d ' ' -f 2)"

    if [[ ! ("$status" = "playing") ]]; then
        return
    fi

    echo $output

    title="$(cmus-remote -Q 2>/dev/null | grep 'title' | cut -d ' ' -f 3-)"
    if [[ $title = "" ]]; then
        tite="-"
    fi
    artist="$(cmus-remote -Q 2>/dev/null | grep -m 1 'artist' | cut -d ' ' -f 3-)"
    if [[ $artist = "" ]]; then
        artist="-"
    fi

    np="$artist / $title"
    echo "$np"
    exit 0
}

np_spotify() {
    output="$(spotify status 2>/dev/null | awk '{print; print ";"}')"
    status="$(echo $output | awk -F ' ; ' '{print $1}')"

    if [[ "$status" = "" ]]; then
        return
    fi

    title="$(echo $output | awk -F ' ; ' '{print $2}' | awk -F ': ' '{print $2}')"
    if [[ $title = "" ]]; then
        tite="-"
    fi
    artist="$(echo $output | awk -F ' ; ' '{print $3}' | awk -F ': ' '{print $2}')"
    if [[ $artist = "" ]]; then
        artist="-"
    fi

    np="$artist / $title"
    echo "$np"
    exit 0
}

np_cmus

echo "-"
# np_xap
