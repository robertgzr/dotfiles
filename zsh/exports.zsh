# Path
export PATH=/tmp/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin
    export PATH=$PATH:/opt/X11/bin
    export PATH=$PATH:$TEXLIVE
    export PATH=$(brew --prefix homebrew/php/php54)/bin:$PATH
    export PATH=$PATH:$GOROOT/bin
    export PATH=$PATH:$GOPATH/bin
    export PATH=$PYENV_ROOT/shims:$PATH

# Dotfiles
export DOT=~/.dotfiles
# ZSH
export ZSHDIR=$HOME/.zsh

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

export EAGLE_DIR=$HOME/Documents/eagle

# GitHub token with no scope, used to get around API limits
export HOMEBREW_GITHUB_API_TOKEN=$(cat $DOT/gh_api_token)

# Python
# export PYTHONPATH=/usr/local/lib/python2.7/site-packages
export PYENV_ROOT=/usr/local/opt/pyenv
export PYENV_SHELL=zsh
## virtualenv
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2.7
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true

# Go
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/Development/go

# Ruby
export GEM_PATH=$DOT/gem

# Java
export JAVA_HOME=/Library/Java/Home
export JUNIT_HOME=$HOME/Development/CE-HTW/softwaretechnik/junit_test/


# postgreSQL
export PGDATA=/usr/local/pgsql/data

# Lime Config
export PKG_CONFIG_PATH=/usr/local/opt/pyenv/versions/3.4.3/lib/pkgconfig/:/usr/local/opt/qt5/lib/pkgconfig:/usr/local/opt/oniguruma/lib/pkgconfig


# ==== zsh modules configuration envs

# configure autosuggestion
export AUTOSUGGESTION_HIGHLIGHT_COLOR=fg=$FG[241]
export AUTOSUGGESTION_HIGHLIGHT_CURSOR=0
export AUTOSUGGESTION_ACCEPT_RIGHT_ARROW=1

# histroy substring highlight colors
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=white,bold'
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'
export HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'

# activate highlighters
# to tweak > zsh/modules/syntax-highlighting/highlighters
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor

# fasd
export _FASD_DATA=$ZSHDIR/tmp/fasd_data
export _FASD_BLACKLIST=$ZSHDIR/tmp/fasd_blacklist