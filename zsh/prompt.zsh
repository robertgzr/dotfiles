#!/usr/bin/env zsh

# prints the current directory (short/long format)
function prompt_dir() {
    if [[ $1 = long ]]; then
        # long path
        prompt_pwd=" %~%<< "
    else
        # shortend path behaviour
        local pwd="${PWD/#$HOME/~}"

        if [[ "$pwd" == '(#m)[/~]' ]]; then
            prompt_pwd="$MATCH"
            unset MATCH
        else
            prompt_pwd="$FG[002]$FX[no-bold]$FX[italic]${${${${(@j:/:M)${(@s:/:)pwd}##.#?}:h}%/}//\%/%%}/${${pwd:t}//\%/%%}"
        fi
    fi
}

# prints the time since login to shell instance
function prompt_paradox_print_elapsed_time {
    local end_time=$(( SECONDS - _prompt_minimal_start_time ))
    local hours minutes seconds remainder
    local PreStr="⚑"

    if (( end_time >= 3600 )); then
        hours=$(( end_time / 3600 ))
        remainder=$(( end_time % 3600 ))
        minutes=$(( remainder / 60 ))
        seconds=$(( remainder % 60 ))
        print -P "%B%F{red}$PreStr elapsed time ${hours}h${minutes}m${seconds}s%b"
    elif (( end_time >= 60 )); then
        minutes=$(( end_time / 60 ))
        seconds=$(( end_time % 60 ))
        print -P "%B%F{yellow}$PreStr elapsed time ${minutes}m${seconds}s%b"
    elif (( end_time > 10 )); then
        print -P "%B%F{green}$PreStr elapsed time ${end_time}s%b"
    fi
}

# ==== Prompt constructor functions

# executes prior to any command
function prompt_precmd {
    prompt_update_context
    prompt_dir

    PROMPT='$prompt_context$FG[002]$prompt_pwd%{%f%}$FX[reset] $FG[255]> '

    # git status on the right
    if [[ -f "$(which porcelain)" ]]; then
        RPROMPT='$(porcelain -fmt)'
    fi

    # Calc elapsed time
    prompt_paradox_print_elapsed_time
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
