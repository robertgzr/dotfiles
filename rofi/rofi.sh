#!/bin/sh

set -ex

exec /usr/bin/rofi -theme hibiki -font 'Iosevka 12' -drun-icon-theme Papirus -show-icons $@
