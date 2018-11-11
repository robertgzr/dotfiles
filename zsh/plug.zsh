#!/bin/env zsh

source $ZPLUG_HOME/init.zsh

zplug "zplug/zplug", hook-build:"zplug --self-manage"

# zplug "zsh-users/zsh-completions"

# zplug "zsh-users/zsh-autosuggestions", defer:2
#     ZSH_AUTOSUGGEST_USE_ASYNC=true
#     ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='none'

zplug "zsh-users/zsh-history-substring-search", defer:2
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=white,bold'
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'
    HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'
    HISTORY_SUBSTRING_SEARCH_FUZZY=true
    bindkey -M vicmd 'k' history-substring-search-up
    bindkey -M vicmd 'j' history-substring-search-down

zplug "zsh-users/zsh-syntax-highlighting", defer:2
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor line root)
    typeset -A ZSH_HIGHLIGHT_STYLES
    ZSH_HIGHLIGHT_STYLES[path]='underline'
    ZSH_HIGHLIGHT_STYLES[path_prefix]='none'

zstyle ':prezto:module:autosuggestions' color 'yes'
zstyle ':prezto:module:autosuggestions:color' found 'red'
zplug "modules/autosuggestions", from:prezto, defer:2

zplug "modules/completion", from:prezto
zplug "modules/fasd", from:prezto
zplug "lib/spectrum", from:oh-my-zsh
zplug "lib/termsupport", from:oh-my-zsh

zplug "$ZDOTDIR/theme", from:local, as:theme

# Install plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    read -q && echo; zplug install
fi

zplug load
