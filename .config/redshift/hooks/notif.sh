#!/bin/sh

case "$1" in
	period-changed)
		notify-send "redshift" "changed to $3"
		if [ "$3" = "night" ]; then
			ogurictl output --image ~/Pictures/animepics/room/evening.png '*'
		else
			ogurictl output --image ~/Pictures/animepics/room/day.png '*'
		fi
		;;
esac
