#!/bin/sh
set -e
new_colors=$1
config_file_tpl=${2:-alacritty.tpl.yml}
config_file=${3:-alacritty.yml}

set -x
yq m -x "$config_file_tpl" "$new_colors" > "$config_file"
