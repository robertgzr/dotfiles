#!/bin/zsh

in=$1

mime=$(file --mime-type $in | cut -d' ' -f 2)
opener=xdg-open

case $mime in
    inode/directory)    exec nautilus -w $in &>/dev/null &! ;;
    inode/file)         exec nautilus -w $in &>/dev/null &! ;;
    text/*)             exec gedit $in &>/dev/null &! ;;

    image/*)            exec eog -w $in &>/dev/null &! ;;
    video/*)            exec mpv -vo opengl-hq $in &>/dev/null &! ;;
    audio/*)            exec mpv -vo opengl $in &>/dev/null &! ;;

    application/vnd.ms-opentype|application/font-sfnt) exec gnome-font-viewer $in &>/dev/null ;;
    *)                  exec $opener $in &>/dev/null &! ;;
esac
