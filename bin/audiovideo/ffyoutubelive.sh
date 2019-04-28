#!/bin/bash

VBR="1000k"
FPS="30"
DIM="1280x800"
QUAL="ultrafast"

YT_URL="rtmp://x.rtmp.youtube.com/live2"
KEY="r7hk-6fe1-aqxr-a6pf"
# YT_URL=$1
# KEY=$2

SOURCE="${1}"
# DEST="/tmp/cap.mkv"


    # -f avfoundation -i "1:0"
    # -acodec libopus -compression_level 5 -vbr on -application lowdelay -ar 44100 -ab 80k -ac 2 -strict -2 -bufsize 512k \
ffmpeg \
    -i "${SOURCE}" -deinterlace \
    -vcodec libx264 -pix_fmt yuv420p -preset $QUAL -r $FPS -g $((FPS * 2)) -vb $VBR -s $DIM \
    -an \
    -f flv "$YT_URL/$KEY"
