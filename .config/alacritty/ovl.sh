#!/bin/sh
set -e

colors_yml=$1
[ -z "$colors_yml" ] && exit 1

set -x
yq m -x overlay.yml "$colors_yml" > alacritty.yml
