#!/bin/env zsh
# ==== FUNCTIONS

# refresh ZSH configuration
function source-zsh {
  source "$ZDOTDIR/.zshrc"
}

# Previews files in Quick Look.
# Author:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
function ql {
  if (( $# > 0 )); then
    qlmanage -p "$@" &> /dev/null
  fi
}

# Displays the Mac OS X download history.
# Author:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
function download-history {
  local db
  for db in ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV*; do
    if grep -q 'LSQuarantineEvent' < <(sqlite3 "$db" .tables); then
      sqlite3 "$db" 'SELECT LSQuarantineDataURLString FROM LSQuarantineEvent'
    fi
  done
}

# ==== Load more good stuff:
source $DOT_DIR/zsh/additionals/ffmpeg_functions.zsh
source $DOT_DIR/zsh/additionals/ze-best-zsh-config_functions.zsh

function mcd {
    mkdir $1 && cd $1
}

# == Fuzzy search scripts using fzf

# cd using fzf
function cdf {
  local file
  local dir
  file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# full shell power: fzf + fasd
# to open a file in sublime text
function sublf {
  local file
  file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && subl -n "${file}" || return 1
}

# select with fzf + fasd
# open the file in mpv
function mpvf {
  local file
  file="$(fzf +m -q "$1")" && mpv "${file}" || return 1
}

#
function mpvp {
    if [ "$#" = 0 ]; then
        mpv `pbp` --profile=ydl
    elif [ "$1" = "-a" ]; then
        mpv `pbp` --no-video --vo=null --term-osd=force --term-osd-bar=yes --term-osd-bar-chars="[+>-]" --term-playing-msg="> ${filename}" --input-app-events=yes --ytdl
    elif [ "$1" = "-l" ]; then
        mpv `pbp` --profile=ydl --loop
    elif [ "$#" = 1 ]; then
        mpv `pbp` --profile=ydl --ytdl-format=$1
    elif [ "$#" = 2 ]; then
        mpv `pbp` --profile=$2 --ytdl-format=$1
    else
        echo "m -mpvp [youtube-dl format] [profile]"
    fi
}

function mpva()
{
  mpv --no-video --vo=null --term-osd=force --term-osd-bar=yes --term-osd-bar-chars="[+>-]" --term-playing-msg="> ${filename}" --input-app-events=yes --ytdl $1
}

# start firefox with dev-profile
function firefoxcli() {
    $FIREFOX --new-instance -P "dev";
}

# Execute a command in the same directory but in a new tab
# function tcmd() {
#   if [[  $TERM_PROGRAM != iTerm.app ]]; then
#       open -a Terminal
#       return 0
#   fi
#   # First, get the directory for the new tab
#   ThisDirectory=$PWD

#   if [[ $# == 0  ]]; then
#         print "usage: $0 [commands]"
#         return 1
#   fi

#   osascript <<-eof
# eof
# }

# set AppleShowAllFiles to TRUE or FALSE
function findershowall() {
    defaults write com.apple.finder AppleShowAllFiles $1;
    killall Finder;
    echo 'set AppleShowAllFiles to '$1;
}

# encfs FakeSeagate shortcut
function encfsfs() {
    encfs /Volumes/Transcend/FSeagate/.encfs-raw /Volumes/Transcend/FSeagate/FS;
    #ln -s /Volumes/Transcend/FSeagate/FS /Volumes/FakeSeagate;
}

function xvmup {
    VBoxManage startvm i3-Xubuntu --type headless
    if [[ "$1" = "-v" ]]; then
        echo "xvmup 0.1 - Headless start of Xbuntu Virtual Machine"
    fi
}
