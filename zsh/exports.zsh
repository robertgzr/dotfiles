# ==== ENVS

# Go
#export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/devel/go

# Path
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/opt/X11/bin
# export PATH=$PATH:$(brew --prefix homebrew/php/php54)/bin

# export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig/:$PKG_CONFIG_PATH
# Lime Config
# export PKG_CONFIG_PATH=/usr/local/opt/pyenv/versions/3.4.3/lib/pkgconfig/:/usr/local/opt/qt5/lib/pkgconfig:/usr/local/opt/oniguruma/lib/pkgconfig

# Setup terminal, and turn on colors
export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad

# Enable color in grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='3;33'

# This resolves issues install the mysql, postgres, and other gems with native non universal binary extensions
export ARCHFLAGS='-arch x86_64'

export LESS='-F -g -i -M -R -S -w -X -z-4 --ignore-case --raw-control-chars'
export PAGER='less'
# configure less colors
    export LESS_TERMCAP_mb=$'\E[01;31m'      # Begins blinking.
    export LESS_TERMCAP_md=$'\E[01;31m'      # Begins bold.
    export LESS_TERMCAP_me=$'\E[0m'          # Ends mode.
    export LESS_TERMCAP_se=$'\E[0m'          # Ends standout-mode.
    export LESS_TERMCAP_so=$'\E[00;47;30m'   # Begins standout-mode.
    export LESS_TERMCAP_ue=$'\E[0m'          # Ends underline.
    export LESS_TERMCAP_us=$'\E[01;32m'      # Begins underline.
export EDITOR="vim"
export VISUAL="subl -n"

# export EAGLE_DIR=$HOME/Documents/eagle

# GitHub token with no scope, used to get around API limits
# export HOMEBREW_GITHUB_API_TOKEN=$(cat $DOT_DIR/gh_api_token)

# Python
# export PYTHONPATH=$(brew --prefix)/lib/python2.7/site-packages
# export PYTHONPATH=$PYTHONPATH:/usr/local/Cellar/opencv/2.4.12/lib/python2.7/site-packages

export PYENV_ROOT=/usr/local/var/pyenv

# UTF-8 locale fix for Python
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# VirtualEnv
export WORKON_HOME=/usr/local/var/virtualenvs
# export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2.7
# export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"

# Django
# export ENV_ROLE=development
# export CRMEASY_DB_PASS=pg
# export SECRET_KEY='l6w=)99mi_^$=p9^d2=%8qvl7@fee$0=s=k$(@4cwldmjgyo1e'


# Ruby
# export GEM_PATH=$DOT_DIR/gem

# Java
export JAVA_HOME=/Library/Java/Home
export JUNIT_HOME=$HOME/Development/CE-HTW/softwaretechnik/junit_test/


# postgreSQL
# export PGDATA=/usr/local/pgsql/data

# Arduino
# export ARDUINODIR=/opt/homebrew-cask/Caskroom/arduino/1.6.5-r5/Arduino.app/Contents/Java/
# export BOARD=uno

if [[ $(uname) = "Linux" && -d "$HOME/.linuxbrew" ]]; then
	export PATH="$HOME/.linuxbrew/bin:$PATH"
	export MANPATH="$HOME/linuxbrew/share/man:$MANPATH"
	export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
fi