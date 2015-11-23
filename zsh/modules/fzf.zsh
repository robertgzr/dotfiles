# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/robertgz/.dotfiles.bkup/fzf/bin* ]]; then
  export PATH="$PATH:/Users/robertgz/.dotfiles.bkup/fzf/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == */Users/robertgz/.dotfiles.bkup/fzf/man* && -d "/Users/robertgz/.dotfiles.bkup/fzf/man" ]]; then
  export MANPATH="$MANPATH:/Users/robertgz/.dotfiles.bkup/fzf/man"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/robertgz/.dotfiles.bkup/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/robertgz/.dotfiles.bkup/fzf/shell/key-bindings.zsh"

