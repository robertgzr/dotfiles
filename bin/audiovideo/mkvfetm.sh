#!/bin/env zsh
# 
# MKV First Extract Then Merge
#

USAGE="usage: mkvfetm.sh MKV_FILE ATTACHMENT_FOLDER"
TEMP=/tmp/mkvfetm_temp

if (( $# > 2 )); then
  echo "to many arguments"
  echo $USAGE
  exit 1
fi

if (( $# < 2 )); then
  echo "not enough arguments"
  echo $USAGE
  exit 1
fi

if [[ ! -f $1 ]]; then
  echo "first argument doesn't exist or is not a file"
  echo $USAGE
  exit 1
fi

if [[ ! -d $2 ]]; then
  echo "second argument doesn't exist or is not a directory"
  echo $USAGE
  exit 1
fi

mediainfo $1 | grep "Movie name"

mkdir -v $TEMP 2>/dev/null && echo "created temp dir"

echo "Extracting shit from source file..."
# mkvextract tracks $1 0:$TEMP/$1".mkv" 1:$TEMP/$1".mka" &>/dev/null
mkvextract tags $1 > $TEMP/$1".tags.xml" &>/dev/null
mkvextract chapters $1 > $TEMP/$1".chapters.xml" &>/dev/null

ls $TEMP

mkvmerge -v -o $1".new.mkv" --global-tags $TEMP/$1".tags.xml" --chapters $TEMP/$1".chapters.xml" $1 --no-attachments --no-subtitles $2/track1_eng.ass $2/track2_eng.ass #@vivid-options

# --attachment-mime-type "application/x-truetype-font" --attach-file $2/attachments/*.ttf ---attachment-mime-type "application/x-opentype-font" -attach-file $2/attachments/*.otf

echo "\nend here..."
