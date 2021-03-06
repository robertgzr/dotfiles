# ==== OSX ENVS ===

export XDG_CACHE_HOME="$HOME/Library/Caches"
export XDG_DATA_HOME="$HOME/Library"

# === Paths ===
export X11PATH=/opt/X11
_extend_path_after $X11PATH/bin

# export PHPPATH=$(brew --prefix homebrew/php/php@5.4)

export TEXPATH=/usr/local/texlive/2016basic
_extend_path_after $TEXPATH/bin/x86_64-darwin

# Python
# export PYTHONPATH=$(brew --prefix)/lib/python2.7/site-packages
# export PYTHONPATH=$PYTHONPATH:/usr/local/Cellar/opencv/2.4.12/lib/python2.7/site-packages
# export PYTHONPATH=$PYTHONPATH:~/.config/beets/extplugins

# export GOAPPENGINE=$HOME/devel/go_appengine/

# Ruby Gems
# export GEMPATH=$HOME/.gem/ruby/2.0.0

# === More ===

# Eagle CAD
export EAGLE_DIR=$HOME/Documents/eagle

# GitHub token with no scope, used to get around API limits
export HOMEBREW_GITHUB_API_TOKEN=$(cat $DOT_DIR/brew_api_token)

# Java
# export JAVA_HOME=$(/usr/libexec/java_home)
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_66.jdk/Contents/Home/

# Arduino
export ARDUINODIR=/opt/homebrew-cask/Caskroom/arduino/1.6.5-r5/Arduino.app/Contents/Java/
export BOARD=uno

# Android
 # export ANDROID_HOME=/usr/local/opt/android-sdk
 export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# OCAML
export OPAMROOT=$HOME/.opam
