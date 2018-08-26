#!/usr/bin/env zsh

# put file into the trash NOT delete
function trash {
  local path
  for path in "$@"; do
    # ignore any arguments
    if [[ "$path" = -* ]]; then :
    else
      local dst=${path##*/}
      # append the time if necessary
      while [ -e ~/.Trash/"$dst" ]; do
        dst="$dst "$(date +%H-%M-%S)
      done
      /bin/mv "$path" ~/.Trash/"$dst"
    fi
  done
}

# set AppleShowAllFiles to TRUE or FALSE
function findershowall() {
    defaults write com.apple.finder AppleShowAllFiles $1;
    killall Finder;
    echo 'set AppleShowAllFiles to '$1;
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

