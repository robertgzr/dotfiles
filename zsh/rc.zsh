#!/bin/env zsh

fpath=(
    /usr/local/share/zsh-completions
    /usr/local/share/zsh/site-functions
    $fpath
)

source $ZDOTDIR/_helpers.zsh
source $ZDOTDIR/plug.zsh
source $ZDOTDIR/exports.zsh

# platform-specific stuff
case `uname -o` in
    *Darwin*)
        source $ZDOTDIR/macos/rc.zsh
        ;;
    *Linux*)
        source $ZDOTDIR/linux/rc.zsh
        ;;
esac

source $ZDOTDIR/setopt.zsh
source $ZDOTDIR/functions.zsh
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/history.zsh
source $ZDOTDIR/bindkeys.zsh

# fuzzy search with fzf
# [[ -f $HOME/.fzf.zsh ]] && source $HOME/.fzf.zsh
[[ -n $(command -v rg) ]] && {
    rg='rg --files --no-ignore-vcs --hidden --follow --glob'
    export FZF_DEFAULT_COMMAND="$rg || fd --type f || git ls-tree -r --name-only HEAD || find .";
    export SKIM_DEFAULT_COMMAND="$rg || fd --type f || git ls-tree -r --name-only HEAD || find .";
    export RIPGREP_CONFIG_PATH=$DOT_DIR/ripgreprc;
}

# fuzzy search with skim/sk
[[ -f $HOME/.skim/bin/sk ]] && {
    _extend_path_after $HOME/.skim/bin
    # [[ ! "$PATH" == *$HOME/.skim/bin* ]] && export PATH="${PATH:+${PATH}:}$HOME/.skim/bin"
    [[ $- == *i* ]] && source $HOME/.skim/shell/completion.zsh 2>/dev/null
    source $HOME/.skim/shell/key-bindings.zsh;
}

# source .env when entering a directory
# TODO: move this into zplug (there is a prezto module)
[[ -n $(command -v direnv) ]] && eval "$(direnv hook zsh)"

# setup: pyenv
[[ -n $(command -v pyenv) ]] && eval "$(pyenv init -)"

# setup: keychain
[[ -f $(command -v keychain) ]] && eval "$(keychain -q --eval --agents ssh id_rsa)"

# echo -n "\033]0;>_ ${USER}@${HOST}\007"

# setup: todo cd hook
if command -v todo &>/dev/null; then eval "$(todo hook cd)"; fi
