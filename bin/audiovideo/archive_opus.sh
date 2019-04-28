#!/bin/env zsh
#
# Converts folder contents to Opus

function convert
{
    ffmpeg -i $1 -acodec libopus -b:a $2 -ac 2 -application audio ${1}.${2}.opus
}

function zipup
{
    # might add this
}

if [[ ! -d $HOME/Music/demoswip ]]; then
    mkdir $HOME/Music/demoswip
fi

for f in "$1"/*.(aif|wav); do
    convert $f "$2";
    osascript -e "display notification \">>> $f\" with title \"OPUS Archiver: Convert done.\"";
    rm -f $f;
done

for opus in "$1"/*.opus; do
    mv $opus "$3"
done
