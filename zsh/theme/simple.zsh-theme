#!/bin/env zsh

local cdir=""
local git_info=""

__prompt::dir() 
{
    unset cdir
    cdir="${PWD/#$HOME/~}"
    # if (( ${#cdir} > 20 ))
    # then
    #     cdir+="
# "
    # fi
}

# __prompt::venv()
# {
#     local venv=""
#     # goenv
#     if [ -n "$GOENV" ]; then
#         venv+=" %{$FX[bold]$FG[012]%}($GOENV)%{$FX[none]%}"
#     fi

#     # pyenv
#     if [[ ! -z "$(which pyenv)" ]]; then
#         if [[ "$(pyenv local &>/dev/null)" = 0 ]]; then
#             pyv="$(pyenv version-name)"
#             venv+=" %{$FX[bold]$FG[010]%}($pyv)%{$FX[none]%}"
#         fi
#     fi

#     # rbenv
#     if [[ ! -z "$(which rbenv)" ]]; then
#         if [[ "$(rbenv local &>/dev/null)" = 0 ]]; then
#             rbv="$(rbenv version-name)"
#             venv+=" %{$FX[bold]$FG[009]%}($rbv)%{$FX[none]%}"
#         fi
#     fi
#     if [[ ! -z $venv ]]; then
#         echo " →$venv"
#     fi
# }

__prompt::git()
{
    unset git_info
    if [[ ! -z "$(command -v porcelain)" ]]; then
        git_info+=$(porcelain -zsh)
        [[ ! -z $git_info ]] && git_info=" → $git_info"
    fi
}

__prompt::mk()
{
    unset PROMPT
    unset RPROMPT
    unset line_break

    __prompt::dir
    __prompt::git

    if (( $(( ${#cdir} + ${#git_info} )) > 20 )); then
        line_break=$'\n'
    fi

    PROMPT='%{$bold$FG[014]%}${cdir}%{$reset_color%}${git_info} ${line_break}❱ '
    RPROMPT=''
}

autoload -Uz spectrum
autoload -Uz add-zsh-hook

add-zsh-hook precmd __prompt::mk
