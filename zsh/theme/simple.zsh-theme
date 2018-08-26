#!/bin/env zsh

# prints the current directory (short/long format)
__prompt::dir() 
{
    local p="${PWD/#$HOME/~}"
    local dir="${p}%{$reset_color%}"
    echo $dir
    if (( ${#p} > 20 )); then
        echo "\0"
    fi
}

__prompt::venv()
{
    local venv=""
    # goenv
    if [ -n "$GOENV" ]; then
        venv+=" → "
        venv+="%{$fg_bold[blue]%}$GOENV%{$reset_color%}"
    fi

    # pyenv
    if [[ ! -z "$(which pyenv)" ]]; then
        pyv="$(pyenv version-name)"
        if [[ $pyv != "system" ]]; then
            venv+=" %{$fg_bold[green]%}$pyv%{$reset_color%}"
        fi
    fi

    # rbenv
    if [[ ! -z "$(which rbenv)" ]]; then
        rbv="$(rbenv version-name)"
        if [[ $rbv != "system" ]]; then
            venv+=" %{$fg_bold[red]%}$rbv%{$reset_color%}"
        fi
    fi
    echo $venv
}

PROMPT='%{$fg_bold[green]%}$(__prompt::dir)$(__prompt::venv) %{$reset_color%}❱ '
RPROMPT=''

# git status on the right
# if [[ -f "$(which porcelain)" ]]; then
#     RPROMPT='$(porcelain -fmt -zsh)'
# fi

# if [ -n "$prompt_session_duration" ]; then
#     print -P "$prompt_session_duration"
# fi
