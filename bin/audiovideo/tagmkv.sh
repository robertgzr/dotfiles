#!/bin/bash

# params
AUDIOFILE=$1
TAGFILE=$2
COVERART=$3

# local
OPUSFILE=

# takes 2 params: AUDIOFILE and BITRATE
encode_opus() {
    if [ -e "$1" ]; then
        echo "Needs audio input"
    fi;
    if [ -e "$2" ]; then
        echo "Needs target bitrate"
    fi;
    OPUSFILE=${1%3}opus
    ffmpeg -i "$1" -acodec libopus -ab "$2" "$OPUSFILE"
}

mux() {
    if [ -e "$1" ]; then
        echo "Needs opus input"
    fi;
    if [ -e "$2" ]; then
        echo "Needs tag file"
    fi;
    if [ -e "$3" ]; then
        echo "Needs cover art"
    fi;
    mkvmerge -o "${1//opus/mka}" --global-tags "$2" "$1" --attach-file "$3"
}

mux $AUDIOFILE $TAGFILE $COVERART
