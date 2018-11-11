#!/bin/env zsh

# prints the current directory (short/long format)
__prompt::dir() 
{
    local p="${PWD/#$HOME/~}"
    echo "${p} "
    if (( ${#p} > 20 ))
    then
        echo "\0"
    fi
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

autoload -Uz spectrum

PROMPT='%{$bold$FG[014]%}$(__prompt::dir)%{$reset_color%}❱ '
# RPROMPT='$(__prompt::venv)'
RPROMPT=''
#
# git status on the right
if [[ -f "$(command -v porcelain)" ]]; then
    RPROMPT+='$(porcelain -fmt -zsh)'
fi
