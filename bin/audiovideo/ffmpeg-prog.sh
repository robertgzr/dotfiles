#!/bin/bash

pv -paIt -N FFMPEG "$IN" | ffmpeg -v 16 "$args" "$IN"
