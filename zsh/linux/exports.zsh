# ==== LINUX ENVs

# Path
export PATH=/opt/bin:$PATH

export XDG_CONFIG_HOME=${HOME}/.config
export XDG_DATA_HOME=${HOME}/.local/share

# linuxbrew
if [[ -f $(command -v brew) ]]; then
    export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
    export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
    export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"
fi

# Java
if [[ -f $(command -v java) ]]; then
    export JAVA_HOME=/usr/lib/jvm/java-7-openjdk
    export PATH=$PATH:$JAVA_HOME/bin
fi
