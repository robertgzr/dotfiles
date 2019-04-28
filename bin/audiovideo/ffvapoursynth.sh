#!/bin/bash

VPY=$1
IN=$(pwd)/$(basename "$2")
SRC_FPS=$3
DST_FPS=$4

if [[ -z $1 || $1 == "-h" ]]; then
    echo "usage: $0 <vpy> <file> <source fps> <destination fps>"
    exit 1;
fi

if [[ -f ${IN}_vs.mkv ]]; then
    rm ${IN}_vs.mkv
fi

if [[ -z $4 ]]; then
    DST_FPS=$(( SRC_FPS * 2 ))
fi

vspipe \
    -a SRC=$IN -a CFPS=$SRC_FPS -a DFPS=$DST_FPS \
    -p $VPY \
    - --y4m | \
    ffmpeg -hide_banner \
    -i pipe: \
    -vcodec libx264 -preset slow -qp 0 \
    -an \
    ${IN}_vs.mkv
