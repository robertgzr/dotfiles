# ==== ALIASES

# Colorize output, add file type indicator, and put sizes in human readable format
alias ls='ls -GFh'
# Same as above, but in long listing format
alias ll='ls -lS'
alias la='ls -la'
alias lsd='ls -ld */'
alias l='ll'

# exa can replace ls if you have it
if [[ -f $(which exa) ]]; then
    alias exa_='/usr/local/bin/exa'
    alias exa='exa -lgHh --git --group-directories-first'
    alias exaa='exa -a@'
    alias exad='exa -d'
    alias exat='exa -T'
    alias l='exa'
fi

# dot expolding (not sure if neccessary)
alias ..="cd .."

# recursive delete of .DS_Store files
alias cleanups="find . -type f -name '*.DS_Store' -ls -delete"
# genereate 256-shasums
alias shasum2.56="shasum --algorithm 256"

# alias py2='python2.7'
# alias py3='python3.5'
alias py='python3'

# ==== Disable correction and globbing
alias ack='noglob ack'
alias cd='nocorrect cd'
alias cp='nocorrect cp'
alias gcc='nocorrect gcc'
alias grep='nocorrect grep'
alias man='nocorrect man'
alias ln='nocorrect ln'
alias mv='nocorrect mv -i'
alias rm='nocorrect rm -i'

alias cp="${aliases[cp]:-cp} -i"
alias rm="${aliases[rm]:-rm} -i"
alias grep="${aliases[grep]:-grep} --color=auto"

alias git='noglob git'
alias find='noglob find'
alias chickenfind="find / -name"
alias history='noglob history'
alias locate='noglob locate'
alias rg='noglob rg'

alias minf="mediainfo"
alias mpv="noglob mpv"
alias youtube-dl="noglob youtube-dl"
alias ydl="noglob youtube-dl"
alias livestreamer="noglob livestreamer"
alias saldl="noglob saldl"
alias weechat="weechat -d $XDG_CONFIG_HOME/weechat"
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

    alias j='fasd_cd -d'
    alias jj='fasd_cd -d -i'
    alias vv='fzf-fasd-vim'

    alias ssh='TERM=xterm-256color ssh'
    alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --enable-dom-distiller &>/dev/null"
    alias htop="sudo htop"
fi

if [[ -f $(which nvim) ]]; then
    alias vvim="$(which vim)"
    alias vim="$(which nvim)"

    alias vvi="$(which vi)"
    alias vi="$(which nvim)"

    alias gvim='gnvim'
    alias vimdiff='nvim -d'
fi

if [[ -f $(which tmux) ]]; then
    alias ta='tmux attach'
    alias tls='tmux ls'
    alias tat='tmux attach -t'
    alias tns='tmux new-session -s'
fi

alias abeet='beet -l ~/.config/beets/animu.db'
alias nlay='$HOME/.dotfiles/nlay'
alias nnn='nnn -l'
alias n='nnn'
