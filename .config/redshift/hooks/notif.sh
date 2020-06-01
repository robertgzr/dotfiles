#!/bin/sh

case "$1" in
	period-changed)
		notify-send "redshift" "changed to $3"
		if [ "$3" = "night" ]; then
			ogurictl output --image ~/.background_night '*'
		else
			ogurictl output --image ~/.background '*'
		fi
		;;
esac
