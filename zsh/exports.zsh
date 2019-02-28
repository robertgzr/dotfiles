# ==== ENVS

# Path
# go
export GOPATH=$HOME/devel/go
export PATH=$GOPATH/bin:$PATH
# rust
export PATH=$PATH:$HOME/.cargo/bin
export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src
# python
export PATH=$PATH:$HOME/.local/bin
# js
export PATH=$PATH:$HOME/.yarn/bin

# the rest
export PATH=$PATH:$GEMPATH/bin:$X11PATH/bin:$PHPPATH/bin:$TEXPATH/bin/x86_64-darwin:$GOAPPENGINE:$OPAMROOT/system/bin

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig/:$PKG_CONFIG_PATH

# Setup terminal, and turn on colors
# export TERM=xterm-256color-italic
export CLICOLOR=1
# export LSCOLORS=Gxfxcxdxbxegedabagacad

# Enable color in grep
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

export EDITOR=nvim
export VISUAL=$EDITOR

# Python
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

# postgreSQL
# export PGDATA=/usr/local/pgsql/data

if command -v rg &>/dev/null; then
    export RIPGREP_CONFIG_PATH=$DOT_DIR/ripgreprc
fi

if command -v sk &>/dev/null; then
    export SKIM_DEFAULT_COMMAND="rg --files || fd --type f || git ls-tree -r --name-only HEAD || find ."
fi

if command -v hub &>/dev/null; then
    export GITHUB_TOKEN=$(cat $DOT_DIR/GH_TOKEN_HUB)
fi
