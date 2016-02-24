#!/usr/bin/env zsh
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

function abspath() {
  # $1 : relative filename
  if [ -d "$(dirname "$1")" ]; then
    echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
  fi
}

# == Fuzzy search scripts using fzf

# supercharged locate
function fzl {
    locate $1 | fzf
}

# cd using fzf
function fzcd {
  local file
  local dir
  file=$(fzf +m -0 -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

function fzjj {
  local dir
  dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "$(dir)" || return 1
}

# open using fzf
function fzopen {
  local file
  local dir
  file=$(fzf +m -0 -q "$1") && open "${file}"
}

function fzmpv {
  local file
  file=$(fzf +m -0 -q "mkv$ | mp4$ | 3gp$ $1") && mpv "$(file)"
}

# full shell power: fzf + fasd
# to open a file in sublime text
function fzsubl {
  local file
  file=$(fzf +m -0 -q "$1") && subl "$(file)" || return 1
}

function fzss {
  local file
  file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && subl "${file}" || return 1
}

# full shell power: fzf + fasd
# to open a file in sublime text
function fzvim {
  local file
  file=$(fzf +m -0 -q "$1") && nvim "$(file)" || return 1
}

function fzvv {
  local file
  file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && nvim "${file}" || return 1
}

# mpv for lazy me
function mpvp {
    if [[ $# -eq 0 ]];
    then
      mpv `pbp` --profile=ydl
    elif [[ $# -eq 1 ]];
    then
      if [[ $1 = "-a" ]];
      then
        mpv `pbp` --no-video --vo=null --term-osd=force --term-osd-bar=yes --term-osd-bar-chars="[+>-]" --term-playing-msg="> ${filename}" --input-app-events=yes --ytdl
      elif [[ $1 = "-loop" ]];
      then
        mpv `pbp` --profile=ydl --loop
      elif [[ $1 = "fuck" ]]
      then
        youtube-dl -F `pbp`
      else
        echo "figure something out please"
      fi
    elif [[ $# -eq 2 ]];
    then
      if [[ $1 = "-f" ]];
      then
        mpv `pbp` --profile=ydl --ytdl-format=$2
      else
        echo "something went wrong"
      fi
    else
      echo "mpvp [options] <youtube-dl format> <profile>"
      echo \n"Options:"
      echo \t"-a"\t"plays only audio"
      echo \t"-loop"\t"loops endlessly"
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

function encfs-mount() {
    echo "$(abspath $1)" /mnt/$2
    encfs "$(abspath $1)" /mnt/$2
}

# encfs FakeSeagate shortcut
function encfsfs() {
    encfs /Volumes/rTranscend/FSeagate/.encfs-raw /mnt/FakeSeagate
}

function xvmup {
    VBoxManage startvm i3-Xubuntu --type headless
    if [[ "$1" = "-v" ]]; then
        echo "xvmup 0.1 - Headless start of Xbuntu Virtual Machine"
    fi
}

# locate & open
function lopen {
    if [[ $# = 0 ]]; then
        echo "nüscht da."
        return
    fi
    FILE=$1
    FOPEN=$(locate -l 1 $FILE)
    open $FOPEN
}
