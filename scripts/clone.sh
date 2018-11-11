#!/bin/env zsh

main() {
    URL=$1
    if [[ $URL = "" ]]
    then
        fail "no input"
    fi
    URL=${URL//(http|https):\/\//}

    make_dirs $URL
    clone $URL
}

make_dirs() {
    URL=$1

    if [[ -d $URL ]]
    then
        return
    fi

    confirm "create $URL"
    mkdir -p "$URL"
}

clone() {
    in=$1
    URL=( ${(ps:/:)in} )

    case $URL[1] in
        github.com ) ssh_clone gh $in;;
        gitlab.com ) ssh_clone gl $in;;
        bitbucket.org ) ssh_clone bb $in;;
        * ) http_clone ${URL// /\/};;
    esac
}

ssh_clone() {
    prefix=$1
    URL=( ${(ps:/:)2} )

    ssh_url="$prefix:$URL[2]/$URL[3]"
    confirm "clone $ssh_url"
    git clone $ssh_url "./${URL// //}"
}

http_clone() {
    URL=$1

    http_url="https://$URL"
    confirm "clone $http_url"
    git clone $GIT_FLAGS $http_url "./$URL"
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

main $@
