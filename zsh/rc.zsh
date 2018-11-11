#!/bin/env zsh

fpath=(
    /usr/local/share/zsh-completions
    /usr/local/share/zsh/site-functions
    $fpath
)

source $ZDOTDIR/plug.zsh
source $ZDOTDIR/exports.zsh

# platform-specific stuff
case "$(uname)" in
    Darwin)
        source $ZDOTDIR/macos/rc.zsh
        ;;
    Linux)
        source $ZDOTDIR/linux/rc.zsh
        ;;
esac

source $ZDOTDIR/setopt.zsh
source $ZDOTDIR/functions.zsh
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/history.zsh
source $ZDOTDIR/bindkeys.zsh

# fuzzy search with fzf
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
# use ripgrep for fzf file search
# --files : list files that would be searched
# --no-ignore : don't respect .gitignore, etc.
# --hidden : search hidden files/dirs
# --follow : follow symlinks
# --glob : additional conditions (here: ignorr everything in .git/)
[[ -f $(which rg &>/dev/null) ]] && export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*" .'
#
# source .env when entering a directory
[[ -f $(which direnv) ]] && eval "$(direnv hook zsh)"

# setup: pyenv
[[ -f $(which pyenv) ]] && eval "$(pyenv init -)"
