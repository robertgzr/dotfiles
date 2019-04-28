#!/bin/sh

# cut up mp4s

_awk_string="awk '{if (\$2 != \"\") system(sprintf(\"ffmpeg -i $2 -ss %s -to %s -c copy ${3}_%s.mp4\", \$1, \$3, NR))}'"

echo $_awk_string
cat $1 | eval $_awk_string
