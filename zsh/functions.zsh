#
# ze-best-zsh-config
# Author:
#   https://github.com/spicycode
function zsh_recompile {
  autoload -U zrecompile
  rm -f ~/.zsh/*.zwc
  [[ -f ~/.zshrc ]] && zrecompile -p ~/.zshrc
  [[ -f ~/.zshrc.zwc.old ]] && rm -f ~/.zshrc.zwc.old

  for f in ~/.zsh/**/*.zsh; do
    [[ -f $f ]] && zrecompile -p $f
    [[ -f $f.zwc.old ]] && rm -f $f.zwc.old
  done

  [[ -f ~/.zcompdump ]] && zrecompile -p ~/.zcompdump
  [[ -f ~/.zcompdump.zwc.old ]] && rm -f ~/.zcompdump.zwc.old

  source ~/.zshrc
}

# extractor works for multiple archive types
function extract {
  echo Extracting $1 ...
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xjf $1  ;;
          *.tar.gz)    tar xzf $1  ;;
          *.bz2)       bunzip2 $1  ;;
          *.rar)       unrar x $1    ;;
          *.gz)        gunzip $1   ;;
          *.tar)       tar xf $1   ;;
          *.tbz2)      tar xjf $1  ;;
          *.tgz)       tar xzf $1  ;;
          *.zip)       unzip $1   ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1  ;;
          *)        echo "'$1' cannot be extracted via extract()" ;;
      esac
  else
      echo "'$1' is not a valid file"
  fi
}

# put file into the trash NOT delete
function trash {
  local path
  for path in "$@"; do
    # ignore any arguments
    if [[ "$path" = -* ]]; then :
    else
      local dst=${path##*/}
      # append the time if necessary
      while [ -e ~/.Trash/"$dst" ]; do
        dst="$dst "$(date +%H-%M-%S)
      done
      /bin/mv "$path" ~/.Trash/"$dst"
    fi
  done
}

function strip_diff_leading_symbols {
  local color_code_regex="(\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K])"

  # simplify the unified patch diff header
  sed -r "s/^($color_code_regex)diff --git .*$//g" | \
        sed -r "s/^($color_code_regex)index .*$/\n\1$(rule)/g" | \
        sed -r "s/^($color_code_regex)\+\+\+(.*)$/\1+++\5\n\1$(rule)\x1B\[m/g" |\

  # actually strips the leading symbols
  sed -r "s/^($color_code_regex)[\+\-]/\1 /g"
}

## Print a horizontal rule
function rule {
  printf "%$(tput cols)s\n"|tr " " "─"}}

# ==== Add some more here:

# Previews files in Quick Look.
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
function ql {
  if (( $# > 0 )); then
    qlmanage -p "$@" &> /dev/null
  fi
}

# refresh ZSH configuration
function source-zsh {
  source ~/.zshrc
}

# Displays the Mac OS X download history.
# Author:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
function download-history {
  local db
  for db in ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV*; do
    if grep -q 'LSQuarantineEvent' < <(sqlite3 "$db" .tables); then
      sqlite3 "$db" 'SELECT LSQuarantineDataURLString FROM LSQuarantineEvent'
    fi
  done
}

function mcd()
{
    mkdir $1
    cd $1
}

function mpvp()
{
    if [ "$#" = 0 ]; then
        mpv `pbp` --profile=ydl
    elif [ "$#" = 1 ]; then
        mpv `pbp` --profile=ydl --ytdl-format=$1
    elif [ "$#" = 2 ]; then
        mpv `pbp` --profile=$2 --ytdl-format=$1
    else
        echo "m -mpvp [youtube-dl format] [profile]"
    fi
}
