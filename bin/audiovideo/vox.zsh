#!/usr/bin/env zsh
# control vox from the command line
#

function play_file()
{
    echo "Vox play $1"
    open -g -a "Vox" $1
}

function pause_vox()
{
    echo "Vox pause"
    osascript -e "tell application \"Vox\" to pause"
}

function playpause_vox()
{
    echo "Vox toggle play/pause"
    osascript -e "tell application \"Vox\" to playpause"
}

function show_help()
{
    echo "vox [-play] [-pause] <file>"
}

function run()
{
    if [[ $# -eq 0 ]];
    then
        show_help
    elif [[ $# -eq 1 ]];
    then
        if [[ $1 = "-pause" ]];
        then
            pause_vox
        elif [[ $1 = "-play" ]];
        then
            playpause_vox
        else
            show_help
        fi
    elif [[ $# -eq 2 && $1 = "-play" ]];
    then
        play_file $2
    else
        show_help
       fi
}

run $@