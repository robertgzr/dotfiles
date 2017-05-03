# ==== OSX ENVS ===
export XDG_CACHE_HOME="$HOME/Library/Caches"
export XDG_DATA_HOME="$HOME/Library"

# === Paths ===
export X11PATH=/opt/X11
export PHPPATH=$(brew --prefix homebrew/php/php54)
export TEXPATH=/usr/local/texlive/2016basic
# Go
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/devel/go
# Rust
export RUST_SRC_PATH=$HOME/devel/rust/multirust/rustc-1.13.0/src

# export GOAPPENGINE=$HOME/devel/go_appengine/

# Ruby Gems
export GEMPATH=$HOME/.gem/ruby/2.0.0

# === More ===

# Eagle CAD
export EAGLE_DIR=$HOME/Documents/eagle

# GitHub token with no scope, used to get around API limits
export HOMEBREW_GITHUB_API_TOKEN=$(cat $DOT_DIR/brew_api_token)
export GORELEASER_GITHUB_API_TOKEN=$(cat $DOT_DIR/goreleaser_api_token)

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
