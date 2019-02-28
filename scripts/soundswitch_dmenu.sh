#!/bin/sh
# 
# This script changes the pulseaudio sink for the currently focused application 
#
# If it is run with $1 = global the default sink will be switched instead

set -eo pipefail

ROFI_CMD=/opt/bin/rofi 
ROFI_ARGS="-dmenu -l 5 -i -p pactl"

selected_sink_id=
select_sink() {
    selected_sink_id=`pacmd list-sinks | tr '\n' '\r' | perl -pe 's/[^\r]*index: ([0-9]+).+?name: <([^\r]+)>.+?alsa.card_name = "([^\r]+)"\r.+?(?=index:|$)/\1: \3 \t<\2>\r/g' | tr '\r' '\n' | tail -n +2 | $ROFI_CMD $ROFI_ARGS | perl -pe 's/.*<([^\r]+)>/\1/g'`
}

make_selected_sink_default() {
    pacmd set-default-sink $selected_sink_id
}

move_sink_inputs_to_selected_sink() {
    for sink_input_id in $@; do
        # notify-send "$0" "> pacmd move-sink-input $sink_input_id $selected_sink_id"
        pacmd move-sink-input $sink_input_id $selected_sink_id
    done
}

selected_sink_input_id=
select_sink_input_from_app() {
    selected_sink_input_id=`pacmd list-sink-inputs | tr '\n' '\r' | perl -pe 's/[^\r]*index: ([0-9]+).+?application\.process\.binary = "([^\r]+)"\r.+?(?=index:|$)/\2: \1\r/g' | tr '\r' '\n' | tail -n +2 | grep $1 | perl -pe 's/.*:([^\r]+)/\1/g'`
}

_global() {
    select_sink
    make_selected_sink_default
    move_sink_inputs_to_selected_sink `pactl list sink-inputs short | cut -f 1 | tr '\n' ' '`

    exit 0
}

_focused() {
    focused_pid=`swaymsg -t get_tree | jq '.. | select(.focused? == true) | .pid'`
    focused_app=`cat /proc/$focused_pid/cmdline`
    focused_app=`basename $focused_app`

    select_sink_input_from_app $focused_app
    # notify-send "$0" "$focused_app ($focused_pid) -> $select_sink_input_id"

    if [ -z $selected_sink_input_id ]; then
        # no sink input for this app
        exit 0
    fi

    select_sink
    move_sink_inputs_to_selected_sink $selected_sink_input_id

    exit 0
}

case $1 in
    "global")
        _global
        ;;
    *)
        _focused
        ;;
esac
