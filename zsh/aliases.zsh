# ==== ALIASES

# Colorize output, add file type indicator, and put sizes in human readable format
alias ls='ls -GFh'
# Same as above, but in long listing format
alias ll='ls -lS'
alias la='ls -la'
alias lsd='ls -ld */'
alias l='ll'

# exa can replace ls if you have it
if command -v exa >/dev/null; then
    alias exa_='/usr/local/bin/exa'
    alias exa='exa -lgHh --git --group-directories-first'
    alias exaa='exa -a@'
    alias exad='exa -d'
    alias exat='exa -T'
    alias l='exa'
fi

if command -v bat >/dev/null; then
    alias cat_=$(command -v cat)
    alias cat=$(command -v bat)
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
alias ssh="TERM=xterm-256color $(command -v ssh)"

alias minf="mediainfo"
alias mpv="noglob mpv"
alias youtube-dl="noglob youtube-dl"
alias ydl="noglob youtube-dl"
alias livestreamer="noglob livestreamer"
alias saldl="noglob saldl"
alias weechat="weechat -d $XDG_CONFIG_HOME/weechat"
alias playme="play --buffer 318 -e mu -v 0.6 -d lowpass 3000"

if command -v nvim >/dev/null; then
    alias vim_="$(command -v vim)"
    alias vim="$(command -v nvim)"

    alias vi_="$(command -v vi)"
    alias vi="vim -u NONE"

    alias gvim='gnvim'
    alias vimdiff='nvim -d'
fi

if command -v tmux >/dev/null; then
    alias ta='tmux attach'
    alias tls='tmux ls'
    alias tat='tmux attach -t'
    alias tns='tmux new-session -s'
fi

alias srv='python -m SimpleHTTPServer'
