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

bindkey -v # vi mode
# remove delay when switching modes
export KEYTIMEOUT=1
bindkey -M vicmd 'u' undo
bindkey -a '^R' redo
bindkey '^K'      kill-whole-line
bindkey ' ' magic-space
bindkey '^F' fzf-cd-widget

# function zle-keymap-select zle-line-init
# {
#     # change cursor shape
#     case $KEYMAP in
#         vicmd)      print -n -- "\033[4 q";;  # block cursor
#         viins) print -n -- "\033[6 q";;  # line cursor
#     esac

#     zle reset-prompt
#     zle -R
# }
# function zle-line-finish
# {
#     print -n -- "\033[2 q"  # block cursor
# }
# zle -N zle-line-init
# zle -N zle-line-finish
# zle -N zle-keymap-select
