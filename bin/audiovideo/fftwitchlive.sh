#!/bin/bash

LIVE_KEY="live_109022787_ZEqbbyTW1oGk5tDhz5JMkOs0n2zhHg"
SERVER="live-fra"

process() {
    FPS=30
    THREADS=6
    CBR=1000k
    QUAL=fast
    TUNE=animation
    OUTRES="1280x720"
    AUDIO_RATE=44100

    SOURCE="${1}"
    DEST="${2}"

    ffmpeg \
        -i "${SOURCE}" -r $FPS \
        -vcodec libx264 -g $((FPS * 2)) -keyint_min $FPS -vb $CBR -minrate $CBR -maxrate $CBR -pix_fmt yuv420p \
        -s $OUTRES -preset $QUAL -tune $TUNE \
        -vf subtitles="$(printf "'%s'" "${SOURCE}")" \
        -acodec libmp3lame -ar $AUDIO_RATE -ac 2 \
        -f flv \
        -threads $THREADS -strict normal -bufsize $CBR \
        "$DEST"
}

sling() {
    THREADS=6
    BUF=1000k
    ffmpeg -i "${1}" \
        -c copy -f flv \
        -threads $THREADS -strict normal -bufsize $BUF \
        "${2}"
}

stream() {
    SRC="${1}"
    # 1 = dump, 2 = sling
    MODE="${2}"

    TARGET="rtmp://$SERVER.twitch.tv/app/$LIVE_KEY"
    if [[ $MODE = 1 ]]; then
        TARGET="$HOME/Desktop/fftwitchlive_test.mp4"
    fi

    if [[ $MODE = 2 ]]; then
        echo "slinging..."
        sling "$SRC" "$TARGET"
        exit 0
    fi

    echo "streaming..."
    process "$SRC" "$TARGET"
    exit 0
}

stream "${@}"
