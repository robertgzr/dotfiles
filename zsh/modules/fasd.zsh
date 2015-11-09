# Maintains a frequently used file and directory list for fast access.

# Return if requirements are not found.
if (( ! $+commands[fasd] )); then
  return 1
fi

#
# Initialization
#

fasd_cache=$ZSHDIR/tmp/fasd_cache

# Cache init code.
if [[ -n "$fasd_cache" ]]; then
  fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >! "$fasd_cache" 2> /dev/null
fi

source "$fasd_cache"

unset fasd_cache