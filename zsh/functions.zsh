#
# ze-best-zsh-config
# Author:
#   https://github.com/spicycode
#
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

# cd using fzf
function cdf()
{
  local file
  local dir
  file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# full shell power: fzf + fasd
# to open a file in sublime text
function sublf()
{
  local file
  file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && subl -n "${file}" || return 1
}

# select with fzf + fasd
# open the file in mpv
function mpvf()
{
  local file
  file="$(fzf +m -q "$1")" && mpv "${file}" || return 1
}

function mpvp()
{
    if [ "$#" = 0 ]; then
        mpv `pbp` --profile=ydl
    elif [ "$1" = "-a" ]; then
        mpv `pbp` --no-video --vo=null --term-osd=force --term-osd-bar=yes --term-osd-bar-chars="[+>-]" --term-playing-msg="> ${filename}" --input-app-events=yes --ytdl
    elif [ "$1" = "-l" ]; then
        mpv `pbp` --profile=ydl --loop
    elif [ "$#" = 1 ]; then
        mpv `pbp` --profile=ydl --ytdl-format=$1
    elif [ "$#" = 2 ]; then
        mpv `pbp` --profile=$2 --ytdl-format=$1
    else
        echo "m -mpvp [youtube-dl format] [profile]"
    fi
}

function mpva()
{
  mpv --no-video --vo=null --term-osd=force --term-osd-bar=yes --term-osd-bar-chars="[+>-]" --term-playing-msg="> ${filename}" --input-app-events=yes --ytdl $1
}

# start firefox with dev-profile
function firefoxcli() {
    $FIREFOX --new-instance -P "dev";
}

# Execute a command in the same directory but in a new tab
# function tcmd() {
#   if [[  $TERM_PROGRAM != iTerm.app ]]; then
#       open -a Terminal
#       return 0
#   fi
#   # First, get the directory for the new tab
#   ThisDirectory=$PWD

#   if [[ $# == 0  ]]; then
#         print "usage: $0 [commands]"
#         return 1
#   fi

#   osascript <<-eof
# eof
# }

function streamit()
{
    INRES="1920x1080" # input resolution
    OUTRES="1920x1080" # output resolution
    FPS="60" # target FPS
    GOP="120" # i-frame interval, should be double of FPS,
    GOPMIN="$FPS" # min i-frame interval, should be equal to fps,
    THREADS="2" # max 6
    CBR="1000k" # constant bitrate (should be between 1000k - 3000k)
    QUALITY="ultrafast"  # one of the many FFMPEG preset
    AUDIO_RATE="44100"

    STREAM_KEY="CC-D0B0431E-33ED-6E54-4D2A-F6825CACA9D0-38639"

    # File streaming
    if [[ $1 ]]; then
        ffmpeg -i $1 -f matr -ac 2 -b:a $AUDIO_RATE -vcodec libx264 -g $GOP -keyint_min $GOPMIN -b:v $CBR -minrate $CBR -maxrate $CBR -pix_fmt yuv420p -s $OUTRES -preset $QUALITY -acodec libopus -application lowdelay -threads $THREADS -strict normal -bufsize $CBR "rtmp://stream.connectcast.tv/live/$STREAM_KEY"
    # Desktop streaming
    else;
        ffmpeg -f avfoundation -video_size "$INRES" -framerate "$FPS" -i "1:0" -f flv -ac 2 -b:a $AUDIO_RATE -vcodec libx264 -g $GOP -keyint_min $GOPMIN -b:v $CBR -minrate $CBR -maxrate $CBR -pix_fmt yuv420p -s $OUTRES -preset $QUALITY -tune film -acodec libopus -application lowdelay -threads $THREADS -strict normal -bufsize $CBR "rtmp://stream.connectcast.tv/live/$STREAM_KEY"
    fi
}

# set AppleShowAllFiles to TRUE or FALSE
function findershowall() {
    defaults write com.apple.finder AppleShowAllFiles $1;
    killall Finder;
    echo 'set AppleShowAllFiles to '$1;
}

# encfs FakeSeagate shortcut
function encfsfs() {
    encfs /Volumes/Transcend/FSeagate/.encfs-raw /Volumes/Transcend/FSeagate/FS;
    #ln -s /Volumes/Transcend/FSeagate/FS /Volumes/FakeSeagate;
}

# ffmpeg -> gif script
function gifenc() {
  if [[ "$1" = "-h" ]]; then
    print -n "Usage: gifenc [input] [output] [horizontal resolution for output] [fps]"
  fi
  palette="/tmp/palette.png"
  filters="fps=$4,scale=$3:-1:flags=lanczos"
  ffmpeg -nostats  -i $1 -vf "$filters,palettegen" -y $palette
  ffmpeg -nostats -i $1 -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse" -y $2
}

