#!/bin/sh

nowplaying() {
    proc=$1
    status="$($proc -Q | grep 'status' | cut -d ' ' -f 2)"
    title="$($proc -Q | grep 'title' | cut -d ' ' -f 3-)"
    artist="$($proc -Q | grep -m 1 'artist' | cut -d ' ' -f 3-)"

    np="$artist :: $title"
    if [ "$status" = "playing" ]; then
        echo "♪ $np"
        exit 0
    fi
}

if cmus-remote -Q > /dev/null 2>&1; then
    nowplaying "cmus-remote"
fi

if xap now -Q > /dev/null 2>&1; then
    # nowplaying "xap now"
fi
