# ==== OSX ENVs

# Path
export PATH=$PATH:/opt/X11/bin
export PATH=$PATH:$(brew --prefix homebrew/php/php54)/bin

# Go
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/devel/go

# Eagle CAD
export EAGLE_DIR=$HOME/Documents/eagle

# GitHub token with no scope, used to get around API limits
export HOMEBREW_GITHUB_API_TOKEN=$(cat $DOT_DIR/gh_api_token)

# Java
export JUNIT_HOME=$HOME/Development/CE-HTW/softwaretechnik/junit_test/

# Arduino
export ARDUINODIR=/opt/homebrew-cask/Caskroom/arduino/1.6.5-r5/Arduino.app/Contents/Java/
export BOARD=uno
