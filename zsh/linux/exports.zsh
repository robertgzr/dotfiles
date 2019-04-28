# ==== LINUX ENVs

# Path
_extend_path_before $DOT_DIR/bin/dmenu
_extend_path_before /opt/bin
_extend_path_after /snap/bin

export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share

# wayland
if [[ -n $WAYLAND_DISPLAY ]]; then
    export GDK_BACKEND=wayland
    export CLUTTER_BACKEND=wayland
    export QT_QPA_PLATFORM=wayland
fi

# linuxbrew
if [[ -f $(command -v brew) ]]; then
    _extend_path_before /home/linuxbrew/.linuxbrew/bin
    _extend_path_before /home/linuxbrew/.linuxbrew/share/man MANPATH
    _extend_path_before /home/linuxbrew/.linuxbrew/share/info INFOPATH
fi

# Java
if [[ -f $(command -v java) ]]; then
    export JAVA_HOME=/usr/lib/jvm/java-7-openjdk
    _extend_path_after $JAVA_HOME/bin
fi
