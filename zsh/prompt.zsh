#!/usr/bin/env zsh

# Configure prompt behaviour

autoload -Uz add-zsh-hook
autoload -Uz is_autoloadable

declare -Ua zsh_prompts
zsh_prompts=(
	"minimal"
	"rbz"
)
local current_prompt=$zsh_prompts[1]

source "$DOT_DIR/zsh/modules/prompt/prompt_minimal"

function chprompt {
  if [[ $# > 0 ]]; then
    if is_autoloadable prompt_$@; then
        autoload -Uz prompt_$@
        eval prompt_$@
        unfunction prompt_$current_prompt &>/dev/null
        current_prompt="$@"
    else
        echo "Not an available prompt: $@"
    fi
  else
    echo "Usage: chprompt [name]"
    for p in $zsh_prompts; do
        [[ $p == $current_prompt ]] && printf "%2s %2s\n" '*' $p || printf "%2s %2s\n" '' $p
    done
  fi
}

if is_autoloadable prompt_$zsh_prompts[1]; then
  chprompt $zsh_prompts[1]
else
  chprompt $zsh_prompts[2]
fi