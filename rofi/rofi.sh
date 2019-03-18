#!/bin/sh

set -ex

exec /usr/bin/rofi \
    -theme hibiki \
    -font 'Iosevka R 12' \
    -drun-icon-theme Papirus \
    -show-icons \
    -modi drun,run,combi,window \
    -drun-show-actions \
    -click-to-exit \
    "${@}"
