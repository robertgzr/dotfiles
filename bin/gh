#!/bin/bash

set -e -o pipefail

CURL='curl -sSL'
JQ='jq -r'

GH_ACCESS_TOKEN=${GH_ACCESS_TOKEN:-`cat $DOT_DIR/GH_TOKEN_GH_SCRIPT`}

usage() {
    printf "usage: gh [-v] [commands] [options]\n"
    printf "\ncommands:\n"
    printf " latest REPO\t\t prints the latest version tag of REPO\n"
    printf " release-url REPO TAG\t prints the url to the release TAG of REPO\n"
    printf " gql QUERY\t\t sends a query to the v4 graphql API\n"
    printf "\n"
}

err() {
    echo >&2 "error: $@"
}

has_cmd() {
    if ! command -v $1 1,2&>/dev/null; then
        err "$s not found"
        return 1
    fi
}

gql() {
    local q=$1
    local res=`$CURL https://api.github.com/graphql \
        -X POST \
        -H "Authorization: bearer $GH_ACCESS_TOKEN" \
        -H "Content-Type: application/json" \
        -d "{\"query\":\"query{ $q }\"}"`

    [ ! $? = 0 ] && {
        err `echo $res | $JQ '.message'`
        err "request was" "{\"query\":\"query{ $q }\"}"
        exit 1
    }
    echo $res
}

if [ -z "$GH_ACCESS_TOKEN" ]; then
    err "no github access token"
    exit 1
fi

has_cmd jq

cmd="$1"; opt="$2"
case $cmd in

    gql)
        if [[ -z $opt ]]; then
            err "no QUERY found"
            exit 1
        fi
        gql "$opt" | jq '.'
        exit 0
        ;;

    latest)
        if [[ -z $opt ]]; then
            err "no REPO found"
            exit 1
        fi
        opt=(${opt//\// })
        gql "repository(owner:${opt[0]},name:${opt[1]}){ releases(first:1, orderBy:{field:CREATED_AT, direction:DESC}){ nodes{tag{name}}} }" | $JQ '.data.repository.releases.nodes[].tag.name'
        exit 0
        ;;

    release-url)
        if [[ -z $opt ]]; then
            err "no REPO found"
            exit 1
        fi
        if [[ -z $3 ]]; then
            err "no TAG found"
        fi
        opt=(${opt//\// })
        gql "repository(owner:${opt[0]},name:${opt[1]}){release(tagName:\\\"$3\\\"){url}}" | $JQ '.data.repository.release.url'
        exit 0
        ;;

    *)
        usage
        exit 0
        ;;
esac
