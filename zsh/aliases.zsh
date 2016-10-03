# ==== ALIASES

# Colorize output, add file type indicator, and put sizes in human readable format
alias ls_='ls -GFh'
# Same as above, but in long listing format
alias ll_='/bin/ls -GFhlS'
alias la_='/bin/ls -GFhla'
alias ld_='/bin/ls -ld */'

# use exa to replace ls
alias ls='exa -G'
alias ll='exa -lgHh --git --group-directories-first'
alias la='exa -lagHh --git --group-directories-first'
alias ld='exa -ld'
alias lt='exa -lHhT'

# dot expolding (not sure if neccessary)
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias rmx='rm -rf'
# recursive delete of .DS_Store files
alias cleanups="find . -type f -name '*.DS_Store' -ls -delete"
# genereate 256-shasums
alias shasum2.56="shasum --algorithm 256"

alias unhide="chflags nohidden"
# alias rake='noglob rake'
# alias bower='noglob bower'
# alias git='hub'

# alias py2='python2.7'
# alias py3='python3.5'
alias py='python'

# ==== Disable correction and globbing
alias cd='nocorrect cd'
alias cp='nocorrect cp'
alias gcc='nocorrect gcc'
alias grep='nocorrect grep'
alias man='nocorrect man'
alias ln='nocorrect ln'
alias mv='nocorrect mv'
alias rm='nocorrect rm'

alias find='noglob find'
alias chickenfind="find / -name"
alias history='noglob history'
alias locate='noglob locate'

alias cp="${aliases[cp]:-cp} -i"
alias rm="${aliases[rm]:-rm} -i"
alias grep="${aliases[grep]:-grep} --color=auto"

alias minf="mediainfo"
# alias mpv="noglob mpv"
alias vlc="noglob /opt/homebrew-cask/Caskroom/vlc/2.2.1/VLC.app/Contents/MacOS/VLC"
alias cvlc="vlc --intf=rc"
# alias youtube-dl="noglob youtube-dl"
alias ydl="youtube-dl"
alias livestreamer="noglob livestreamer"
# alias saldl="noglob saldl"
alias weechat="weechat -d $DOT_DIR/config/weechat"
alias playme="play --buffer 318 -e mu -v 0.6 -d lowpass 3000"

# ==== Linux specific
if [[ $(uname) = "Linux" ]]; then
    alias pbcopy='xclip -in'
    alias pbpaste='xclip -out'
    alias ssh='eval $(/usr/bin/keychain --eval --agents ssh -Q --quiet ~/.ssh/*_rsa) && ssh'
    alias git='eval $(/usr/bin/keychain --eval --agents ssh -Q --quiet ~/.ssh/*_rsa) && git'
fi

# ==== OSX specific
if [[ $(uname) = "Darwin" ]]; then
    alias cdf='cd "$(pfd)"'
    alias pushdf='pushd "$(pfd)"'
    alias pbc='pbcopy'
    alias pbp='pbpaste'

    alias cask='brew cask'
    alias caskx='cask zap'
    alias brewup='brew update && brew upgrade --all'
    alias brewx='brew remove --force'

    alias iterm='osascript -e "tell application \"iTerm2\" to (create window with profile \"Default\")"'
    alias imgcat='$HOME/.dotfiles/osx/imgcat.sh'
    alias imgls='$HOME/.dotfiles/osx/imgls.sh'

    alias vvim="$(which vim)"
    alias vim="$(which nvim)"
    alias gvim='gnvim'

    alias dockerup='eval $(docker-machine env default)'
fi

alias tmux="TERM=screen-256color-bce tmux"
alias ta='tmux attach'
alias tls='tmux ls'
alias tat='tmux attach -t'
alias tns='tmux new-session -s'

alias j='fasd_cd -d'
alias jj='fasd_cd -d -i'
alias ss='f -i -e subl'
alias vv='f -i -e nvim'
alias oo='f -i -e open'

alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --enable-dom-distiller &>/dev/null"
alias htop="sudo htop"
