#!/bin/env zsh

# prints the current directory (short/long format)
function prompt_pwd {
    if [[ $1 = long ]]; then
        # long path
        echo " %~%<< "
    else
        # shortend path behaviour
        local pwd="${PWD/#$HOME/~}"

        if [[ "$pwd" == (#m)[/~] ]]; then
            echo "$MATCH"
            unset MATCH
        else
            echo "$FX[no-bold]$FX[italic]${${${${(@j:/:M)${(@s:/:)pwd}##.#?}:h}%/}//\%/%%}/${${pwd:t}//\%/%%}"
        fi
    fi
}

# TODO: needs attention!
function prompt_venv {
    # goenv
    if [ -n "$GOENV" ]; then
        prompt_ctx+=" → "
        prompt_ctx+="$FG[004]$GOENV$FX[reset]"
    fi

    # pyenv
    if [[ ! -z "$(which pyenv)" ]]; then
        pyv="$(pyenv version-name)"
        if [[ $pyv != "system" ]]; then
            prompt_ctx+=" $FG[003]pyv($pyv)$FX[reset]"
        fi
    fi

    # rbenv
    if [[ ! -z "$(which rbenv)" ]]; then
        rbv="$(rbenv version-name)"
        if [[ $rbv != "system" ]]; then
            prompt_ctx+=" $FG[001]rbv($rbv)$FX[reset] "
        fi
    fi

    # virtualenv
    # if [ -n "$VIRTUAL_ENV" ]; then
    #     prompt_ctx += " "
    #     if [ -f "$VIRTUAL_ENV/__name__" ]; then
    #         local name=$(cat $VIRTUAL_ENV/__name__)
    #     elif [ $(basename $VIRTUAL_ENV) = "__" ]; then
    #         local name=$(basename $(dirname $VIRTUAL_ENV))
    #     else
    #         local name=$(basename $VIRTUAL_ENV)
    #     fi
    #     local ctx_virtualenv="$FG[003]ː$name$FX[reset]"
    #     prompt_ctx+="$ctx_virtualenv"
    # fi

    echo "$prompt_ctx"
}

# time since login to shell instance
# TODO: not useful. find a way to log command execution time if >5sec
function prompt_calc_session_duration {
    local end_time=$(( SECONDS - _prompt_minimal_start_time ))
    local hours minutes seconds remainder
    local PreStr="⚑"

    if (( end_time >= 3600 )); then
        hours=$(( end_time / 3600 ))
        remainder=$(( end_time % 3600 ))
        minutes=$(( remainder / 60 ))
        seconds=$(( remainder % 60 ))
        prompt_session_duration="$FG[001]$FX[bold]$PreStr elapsed time ${hours}h${minutes}m${seconds}s$FX[reset]"
    elif (( end_time >= 60 )); then
        minutes=$(( end_time / 60 ))
        seconds=$(( end_time % 60 ))
        prompt_session_duration="$FG[002]$FX[bold]$PreStr elapsed time ${minutes}m${seconds}s$FX[reset]"
    elif (( end_time > 10 )); then
        prompt_session_duration="$FG[006]$FX[bold]$PreStr elapsed time ${end_time}s$FX[reset]"
    else
        prompt_session_duration=""
    fi
}

# ==== Prompt constructor functions

# executes prior to any command
function prompt_precmd {
    prompt_glyph="❱"

    PROMPT='$FG[002]$(prompt_pwd)$FX[reset] $prompt_glyph '

    # git status on the right
    if [[ -f "$(which porcelain)" ]]; then
        RPROMPT='$(prompt_venv)$FX[reset] $(porcelain -fmt)'
    fi

    # if [ -n "$prompt_session_duration" ]; then
    #     print -P "$prompt_session_duration"
    # fi
}

# executes prior to any command execution
function prompt_preexec {
    _prompt_minimal_elapsed_time="$SECONDS"
}

function prompt_minimal {
    autoload -Uz add-zsh-hook

    add-zsh-hook preexec prompt_preexec
    add-zsh-hook precmd prompt_precmd
}

prompt_minimal
