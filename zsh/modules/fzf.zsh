# Setup fzf
# ---------
if [[ ! "$PATH" == *$DOT_DIR/fzf/bin* ]]; then
  export PATH="$PATH:/Users/robertgz/.dotfiles.bkup/fzf/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == *$DOT_DIR/fzf/man* && -d "$DOT_DIR/fzf/man" ]]; then
  export MANPATH="$MANPATH:$DOT_DIR/fzf/man"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$DOT_DIR/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$DOT_DIR/fzf/shell/key-bindings.zsh"

