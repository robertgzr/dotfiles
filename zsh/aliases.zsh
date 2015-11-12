# ==== ALIASES

# Colorize output, add file type indicator, and put sizes in human readable format
alias ls='ls -GFh'
# Same as above, but in long listing format
alias ll='ls -GFhl'
alias la='ls -GFhla'
alias ld='ls -ld */'

# dot expolding (not sure if neccessary)
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias rmx='rm -rf'
# recursive delete of .DS_Store files
alias cleanups="find . -type f -name '*.DS_Store' -ls -delete"

alias unhide="chflags nohidden"
# alias rake='noglob rake'
# alias bower='noglob bower'
# alias git='hub'

# alias py2='python2.7'
# alias py3='python3.5'
alias py='python'

# ==== OSX specific
alias cdf='cd "$(pfd)"'
alias pushdf='pushd "$(pfd)"'
alias pbc='pbcopy'
alias pbp='pbpaste'

alias cask='brew cask'
alias caskx='cask zap'
alias brewup='brew update && brew upgrade --all'
alias brewx='brew remove --force'

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

alias j='fasd_cd -d'
alias jj='fasd_cd -d -i'
alias m='f -e mpv'
alias s='f -e subl'

alias mpv="noglob mpv"
alias vlc="noglob /opt/homebrew-cask/Caskroom/vlc/2.2.1/VLC.app/Contents/MacOS/VLC"
alias cvlc="vlc --intf=rc"
alias youtube-dl="noglob youtube-dl"
alias ydl="youtube-dl"
alias livestreamer="noglob livestreamer"
