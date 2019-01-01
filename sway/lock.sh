#!/bin/env zsh

# in='/home/robert/Pictures/animepics/yande.re 452209 5_nenme_no_houkago kantoku landscape seifuku sweater.jpg'
in=$HOME/.background
img=/tmp/lockscreen.jpg
# grim -t jpeg -q 20 $img

# convert $img -scale 5% -blur 0x2.5 -resize 2000% $img
# $GOPATH/bin/stackblur -radius 60 -in $img -out $img
[[ ! -f $img ]] && $HOME/devel/go/bin/stackblur -radius 60 -in $in -out $img

swaylock -i $img
