#!/bin/sh

case "$1" in
	period-changed)
		case "$3" in
		transition|night)	pkill -USR2 waybar-redshift ;;
		none|day)		pkill -USR1 waybar-redshift ;;
		esac
		;;
esac
