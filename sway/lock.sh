#!/bin/sh

img=/tmp/lockscreen.jpg
grim -t jpeg -q 20 $img

# convert $img -scale 5% -blur 0x2.5 -resize 2000% $img
stackblur -radius 60 -in $img -out $img

swaylock -i $img
rm $img
