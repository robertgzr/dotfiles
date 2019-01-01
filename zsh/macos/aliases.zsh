# alias waterfox=waterfox_no_stderr
alias dtrace='sudo dtrace'
alias anibeets='beet -l ~/.config/beets/animu.db'

alias unhide="chflags nohidden"

alias cdf='cd "$(pfd)"'
alias pushdf='pushd "$(pfd)"'
alias pbc='pbcopy'
alias pbp='pbpaste'

alias brew='TERM=xterm-256color brew'
alias cask='brew cask'
alias caskx='cask zap'
alias brewup='brew update && brew upgrade'
alias brewx='brew remove --force'

alias iterm='osascript -e "tell application \"iTerm2\" to (create window with profile \"Default\")"'
alias imgcat='$HOME/.dotfiles/osx/imgcat.sh'
alias imgls='$HOME/.dotfiles/osx/imgls.sh'

alias dockerup='eval $(docker-machine env default)'

alias ssh='TERM=xterm-256color ssh'
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --enable-dom-distiller &>/dev/null"
alias htop="sudo htop"
