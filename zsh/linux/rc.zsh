source $ZDOTDIR/linux/aliases.zsh
source $ZDOTDIR/linux/exports.zsh

export WAYLAND_DISPLAY=wayland-0

if [ $(tty) = "/dev/tty1" ]; then
    sway
    exit 0
fi
