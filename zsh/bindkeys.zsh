# To see the key combo you want to use just do:
# cat > /dev/null
# And press it

# Use human-friendly identifiers.
# 'Ctrl'        '\C-'
# 'CtrlL'       '\e[1;5D \e[5D \e\e[D \eOd'
# 'CtrlR'       '\e[1;5C \e[5C \e\e[C \eOc'
# 'Esc'         '\e'
# 'Meta'        '\M-'
# 'Back'        "^?"
# 'Del'         "^[[3~"

bindkey "^K"      kill-whole-line                      # ctrl-k
bindkey "^R"      history-incremental-search-backward  # ctrl-r             # up arrow
# bindkey "^?"      vi-delete-char                          # ctrl-d
bindkey "^[[C"      forward-char                         # ctrl-f
bindkey "^[[D"      backward-char                        # ctrl-b
bindkey -e   # Default to standard emacs bindings, regardless of editor string

# arrow navigation
bindkey "^[[1;9C"      forward-word
bindkey "^[[1;9D"      backward-word
bindkey "^[[H"    beginning-of-line                 # Fn-left arrow
bindkey "^[[F"    end-of-line                       # Fn-right arrow

bindkey ' ' magic-space
# bindkey -M menuselect "$terminfo[kcbt]" reverse-menu-complete

# history substring search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# ZAW
bindkey "^[y" zaw-open-file
bindkey "^[x" zaw-history
bindkey "^[c" zaw
