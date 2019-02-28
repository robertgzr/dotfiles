#!/bin/env zsh
#
# To use this create a directory that you want to use for git repos, e.g. $HOME/git and copy/symlink this script into it.
# Then you can use it like this:
#
# ./clone github.com/robertgzr/dotfiles
# ./clone https://bitbucket.org/foo/bar
#
# If you don't have gitconfig set up like I have (using aliases for github/bitbucket ssh access) this won't really work

TEMP=`mktemp -d -p /tmp clone.XXXXXXXXXX`

main() {
    URL=$1
    if [[ $URL = "" ]]
    then
        fail "no input"
    fi
    URL=${URL//(http|https):\/\//}

    clone $URL "$TEMP/$URL" || fail
    install -d `dirname $URL` || fail
    mv "$TEMP/$URL" `dirname $URL` || fail
    rm -rf "$TEMP" || fail
}

make_dirs() {
    local url=$1

    if [[ -d $url ]]
    then
        echo "exists: $url"
        return
    fi

    confirm "create $url"
    mkdir -p "$url"
}

clone() {
    local in=$1
    local to=$2
    local url=( ${(ps:/:)in} )

    case $url[1] in
        github.com ) ssh_clone gh $in $to;;
        gitlab.com ) ssh_clone gl $in $to;;
        bitbucket.org ) ssh_clone bb $in $to;;
        * ) http_clone "${url// /\/}" $to;;
    esac
}

ssh_clone() {
    local prefix=$1
    local to=$3
    local url=( ${(ps:/:)2} )
    local ssh_url="$prefix:$url[2]/$url[3]"

    # confirm "clone $ssh_url"
    git clone $ssh_url $to
}

http_clone() {
    local url=$1
    local to=$2
    local http_url="https://$URL"

    # confirm "clone $http_url"
    git clone $GIT_FLAGS $http_url $to
}

fail() {
    echo "${1:-error}"
    exit ${2:-1}
}

confirm() {
    echo -n "${1:-'do something'}, ok (y/n)? "
    read yn
    if [[ "$yn" = "${yn#[Yy]}" ]]; then
        fail "ok, exiting" 0
    fi
}

case $1 in
    -h|--help)
        echo "usage: $0 <url>"
        echo ""
        echo "url\texample.com/user/repo"
        echo "\thttp[s]://example.com/user/repo"
        exit 0
        ;;
    *)
        main $@
        ;;
esac
