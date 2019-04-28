#!/bin/bash

INPUT=$1
OUPUT=$2

ARGS="-c:a copy -c:v copy"

FFMPEG=$(which ffmpeg)

# Get video duration in frames
duration=$($FFMPEG -i [filename] 2>&1 | sed -n "s/.* Duration: \([^,]*\), start: .*/\1/p")
fps=$($FFMPEG -i [filename] 2>&1 | sed -n "s/.*, \(.*\) tbr.*/\1/p")
hours=$(echo $duration | cut -d":" -f1)
minutes=$(echo $duration | cut -d":" -f2)
seconds=$(echo $duration | cut -d":" -f3)
FRAMES=$(echo "($hours*3600+$minutes*60+$seconds)*$fps" | bc | cut -d"." -f1)

# Start ffmpeg, use awk to flush the buffer and remove carriage returns

$FFMPEG -i $INPUT $ARGS $OUPUT 2>&1 | awk '1;{fflush()}' RS='\r\n'>[errorlog] &

# Get ffmpeg Process ID
PID=$( ps -ef | grep "ffmpeg" | grep -v "grep" | awk '{print $2}' )

# While ffmpeg runs, process the log file for the current frame, display percentage progress
while ps -p $PID>/dev/null  ; do
  currentframe=$(tail -n 1 [errorlog] | awk '/frame=/ { print $2 }')
  if [[ -n "$currentframe" ]]; then
    PROG=$(echo "scale=3; ($currentframe/$FRAMES)*100.0" | bc)
    echo PROGRESS: $PROG
    sleep 1
  fi
done
