# ==== LINUX ENVs

# Path
export PATH=$PATH:/usr/lib/jvm/java-7-openjdk/bin

# linuxbrew stuff
if [[ -d "$HOME/.linuxbrew" ]]; then
    export PATH="$HOME/.linuxbrew/bin:$PATH"
    export MANPATH="$HOME/linuxbrew/share/man:$MANPATH"
    export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
fi

# Go
export GOPATH=$HOME/devel/go

# Java
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk