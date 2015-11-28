function precmd {
  # Put the string "hostname::/full/directory/path" in the title bar:
  # echo -ne "\e]2;$PWD\a"

  # Put the parentdir/currentdir in the tab
  # echo -ne "\e]1;$PWD:h:t/$PWD:t\a"

  # if [[ -n "$TMUX" ]]; then
  #   tmux setenv "$(tmux display -p 'TMUX_PWD_#D')" "$PWD"
  # fi
}

function preexec {
  #autoload -Uz set_running_app
  #set_running_app
}
