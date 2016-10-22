#!/bin/env zsh

# ffmpeg -> gif script
function gifenc()
{
  if [[ "$1" = "-h" ]]; then
    print -n "Usage: gifenc [input] [output] [horizontal resolution for output] [fps]"
  fi
  palette="/tmp/palette.png"
  filters="fps=$4,scale=$3:-1:flags=lanczos"
  ffmpeg -nostats  -i $1 -vf "$filters,palettegen" -y $palette
  ffmpeg -nostats -i $1 -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse" -y $2
}

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
    if [[ ! -z "$1" ]]; then
        ffmpeg -i $1 -f matr -ac 2 -b:a $AUDIO_RATE -vcodec libx264 -g $GOP -keyint_min $GOPMIN -b:v $CBR -minrate $CBR -maxrate $CBR -pix_fmt yuv420p -s $OUTRES -preset $QUALITY -acodec libopus -application lowdelay -threads $THREADS -strict normal -bufsize $CBR "rtmp://stream.connectcast.tv/live/$STREAM_KEY"
    # Desktop streaming
    else;
        ffmpeg -f avfoundation -video_size "$INRES" -framerate "$FPS" -i "1:0" -f flv -ac 2 -b:a $AUDIO_RATE -vcodec libx264 -g $GOP -keyint_min $GOPMIN -b:v $CBR -minrate $CBR -maxrate $CBR -pix_fmt yuv420p -s $OUTRES -preset $QUALITY -tune film -acodec libopus -application lowdelay -threads $THREADS -strict normal -bufsize $CBR "rtmp://stream.connectcast.tv/live/$STREAM_KEY"
    fi
}
