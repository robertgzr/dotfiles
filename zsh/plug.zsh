#!/bin/env zsh

source $ZPLUG_HOME/init.zsh

zplug "zplug/zplug", hook-build:"zplug --self-manage"

zplug "zsh-users/zsh-autosuggestions"
    export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=8

zplug "zsh-users/zsh-history-substring-search"
    export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=white,bold'
    export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'
    export HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'
    bindkey -M vicmd 'k' history-substring-search-up
    bindkey -M vicmd 'j' history-substring-search-down

zplug "zsh-users/zsh-syntax-highlighting", defer:2
    # activate highlighters
    # to tweak > zsh/modules/zsh-syntax-highlighting/highlighters
    export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor line)

zplug "modules/completion", from:prezto
zplug "modules/fasd", from:prezto

# source our own theme
zplug "$ZDOTDIR/theme", from:local, as:theme

# Install plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    read -q && echo; zplug install
fi

zplug load
