# HISTORY
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$HOME/.zsh/zsh_history

# Lists the ten most used commands.
# $1 : number of top spots to list
function history-stat {
    history 0 | awk '{print $2}' | sort | uniq -c | sort -n -r | head -n ${1:-10}
}
