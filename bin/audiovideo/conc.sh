#!/bin/sh

# concatenate multiple mp4s

for f in $@; do
  ffmpeg -i $f -c copy -bsf:v h264_mp4toannexb -f mpegts -y /tmp/concat_tmp_${f}.ts 2> /dev/null
done

ffmpeg -v 24 -f mpegts -i "concat:$(for f in /tmp/concat_tmp*.ts; do printf "%s|" $f; done)" -c copy -bsf:a aac_adtstoasc concat_output.mp4

rm -f /tmp/concat_tmp_*.ts
