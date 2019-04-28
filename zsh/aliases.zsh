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
    export exa_args='-gHh --git --group-directories-first'
    alias exaa="exa ${exa_args} -a@"
    alias exad="exa ${exa_args} -d"
    alias exat="exa ${exa_args} -T"
    alias l="f() {if [ -t 1 ]; then exa ${exa_args} -l \$@; else exa ${exa_args} -1 \$@; fi};f"
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
alias py=python3

# ==== Disable correction and globbing
alias cp='cp -gi'
alias mv='mv -gi'
alias rm='rm -i'

alias git='noglob git'

# ==== Convinience and lazyness
alias grep="grep --color=auto"
alias ssh="TERM=xterm-256color $(command -v ssh)"

alias minf="mediainfo"
alias mpv="mpv --input-ipc-server=/var/run/user/$UID/mpv"
alias ydl=youtube-dl
alias weechat="weechat -d $XDG_CONFIG_HOME/weechat"
alias playme="play --buffer 318 -e mu -v 0.6 -d lowpass 3000"

if command -v nvim >/dev/null; then
    alias vim_="$(command -v vim)"
    alias vim=nvim

    alias vi_="$(command -v vi)"
    alias vi='vim -u NONE'

    alias gvim=gnvim
    alias vimdiff='nvim -d'
fi

if command -v tmux >/dev/null; then
    alias ta='tmux attach'
    alias tls='tmux ls'
    alias tat='tmux attach -t'
    alias tns='tmux new-session -s'
fi

alias srv='python3 -m http.server'
