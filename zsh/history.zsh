# HISTORY
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$ZSHDIR/tmp/zsh_history

# bindkey '^R' zaw-history

# Lists the ten most used commands.
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"
