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

# bindkey -e # emacs mode
bindkey -v # vi mode

# bindkey '^K'      kill-whole-line
# bindkey '^R'      history-incremental-search-backward

# arrow navigation
# bindkey '^[[C'      forward-word
# bindkey '^[[D'      backward-word
# bindkey '^[[H'    beginning-of-line
# bindkey '^[[F'    end-of-line

bindkey ' ' magic-space
# bindkey -M menuselect "$terminfo[kcbt]" reverse-menu-complete

# history substring search
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# remove delay when switching modes
export KEYTIMEOUT=1

bindkey '^F' fzf-cd-widget
