if [ -d "${HOME}/bin" ]; then
	pathprepend "${HOME}/bin"
	pathprepend "${HOME}/bin/$(uname -n)"
fi

if [ -d "${HOME}/AppImages" ]; then
	pathappend "${HOME}/AppImages"
fi

export GOPATH="${HOME}/go"
if [ -d "${GOPATH}" ]; then
	pathappend "${GOPATH}/bin"
fi

if [ -d "${HOME}/.cargo/bin" ]; then
	pathappend "${HOME}/.cargo/bin"
fi

# Use the new build backend in docker
export DOCKER_BUILDKIT=1

# Parallel portage
export NUMCPUS=$(nproc)
export NUMCPUSplusone=$((NUMCPUS + 1))
export MAKEOPTS="-j${NUMCPUSplusone} -l${NUMCPUS}"
export EMERGE_DEFAULT_OPTS="--jobs=${NUMCPUSplusone} --load-average=${NUMCPUS}"

# Set prompt
export PS1="$(prompt)"
# enlable vi mode
set -o vi
bind -m vi-insert -x '"\C-l": clear'

# Set less default options
export LESS='--hilite-search --hilite-unread --long-prompt --raw-control-chars --chop-long-lines'

# Set the rsync ssh command to use by default
export RSYNC_RSH='ssh -T -x -o Compression=no'

# Alias shell commands
# alias logout='dbus-send --session --type=method_call --print-reply --dest='
alias vim=nvim
alias l='exa --long --classify --group --header --group-directories-first'
alias ..='cd ..'
alias ssh='TERM=xterm-256color ssh'
alias rsyncez='rsync --verbose --archive --human-readable --partial --progress --stats --protect-args --rsh="ssh -o Compression=no"'
alias webcam='mpv --profile=webcam av://v4l2:/dev/video0'
alias balssh='ssh -p 22222 -o User=root -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
alias balscp='scp -P 22222 -o User=root -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
