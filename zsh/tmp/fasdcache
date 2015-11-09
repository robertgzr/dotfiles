# add zsh hook
_fasd_preexec() {
  { eval "fasd --proc $(fasd --sanitize $1)"; } >> "/dev/null" 2>&1
}
autoload -Uz add-zsh-hook
add-zsh-hook preexec _fasd_preexec

