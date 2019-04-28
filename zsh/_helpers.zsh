#!/bin/env zsh
# 
# this contains helper functions used throughout my zsh config

function _extend_path_after {
    [[ -z $1 ]] && return
    c='[[ ! "$%%_PATH_%%" == *${1}* ]] && export %%_PATH_%%="${%%_PATH_%%:+${%%_PATH_%%}:}${1}"'
    eval ${c//'%%_PATH_%%'/${2:-PATH}}
}
function _extend_path_before {
    [[ -z $1 ]] && return
    c='[[ ! "$%%_PATH_%%" == *${1}* ]] && export %%_PATH_%%="${1}${%%_PATH_%%:+:${%%_PATH_%%}}"'
    eval ${c//'%%_PATH_%%'/${2:-PATH}}
}
