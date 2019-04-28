#!/bin/bash
#
# Command-line fuckery with video tools / mostly ffmpeg and mkvtools

# ressource links
http://superuser.com/questions/373018/resources-to-use-ffmpeg-effectively/373024#373024
http://blog.superuser.com/2012/02/24/ffmpeg-the-ultimate-video-and-audio-manipulation-tool/
http://www.mplayerhq.hu/DOCS/HTML/en/menc-feat-telecine.html
https://trac.ffmpeg.org/wiki/Map
https://trac.ffmpeg.org/wiki/Encode/H.264
http://www.fatbellyman.com/webstuff/ffmpeg_common_usage/

# Concat VOBs of a DVD and copy all channels into one MKV container without transcoding anything
ffmpeg -analyzeduration 100000k -probesize 100000k -fflags genpts -i "concat:$(echo *.VOB | tr \  \|)" -map 0:v -map 0:a -map 0:s -c copy -y [output file title].mkv

# Put all streams of a DVD into a single MKV file - better than above because it takes care of the chapters too
makemkvcon mkv file:[dvd folder] all [target folder]

# grab the chapters to a movie from chapterdb.org

# input to mkv container: audio -> opus, video -> h.264
ffmpeg -i $i -acodec libopus -b:a 50k -vbr on -vcodec libx264 -preset slow -crf 22 -tune film -profile:v high10 -y ${i//$ext/mkv}

# extract a frame from video
ffmpeg -y -ss [duration into video] -i [source_file] -vframes 1 [target_file]

# cut up a video
ffmpeg -ss [00:00:00.000 fast forward into video] -i [source_file] -ss [accurate seek relative to first seek] -t [duration of new part] -c copy [output]
