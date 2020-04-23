#!/bin/sh

case "$1" in
	period-changed)
		exec notify-send "redshift" "changed to $3" ;;
esac
