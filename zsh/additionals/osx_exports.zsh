# ==== OSX ENVS ===

# === Paths ===
export X11PATH=/opt/X11
export PHPPATH=$(brew --prefix homebrew/php/php54)
export TEXPATH=/usr/local/texlive/2016basic
# Go
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/devel/go

# export GOAPPENGINE=$HOME/devel/go_appengine/

# Ruby Gems
export GEMPATH=$HOME/.gem/ruby/2.0.0

# === More ===

# Eagle CAD
export EAGLE_DIR=$HOME/Documents/eagle

# GitHub token with no scope, used to get around API limits
export HOMEBREW_GITHUB_API_TOKEN=$(cat $DOT_DIR/gh_api_token)

# Java
# export JAVA_HOME=$(/usr/libexec/java_home)
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_66.jdk/Contents/Home/

# Arduino
export ARDUINODIR=/opt/homebrew-cask/Caskroom/arduino/1.6.5-r5/Arduino.app/Contents/Java/
export BOARD=uno

# Android
 export ANDROID_HOME=/usr/local/opt/android-sdk
