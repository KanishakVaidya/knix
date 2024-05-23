#!/usr/bin/env bash

prev_state=$(cat /tmp/prev-connection-state)

IF=$(ip route | awk '/^default/{print $5}')
#echo $IF


if [[ "$IF" = "" ]] || [[ "$(cat /sys/class/net/$IF/operstate)" = 'down' ]]; then
    echo '{"text": " 󰌙 ", "class": "disconnected"}'

    [[ $prev_state == connected  ]] && ( notify-send "Internet" "Disconnected" & echo "disconnected" > /tmp/prev-connection-state ) || true

    exit
elif [[ "$(cat /sys/class/net/$IF/operstate)" = 'up' ]]; then
    [[ $IF == w* ]] && echo '{"text": " 󰤨 ", "class": "connected" }' || echo '{"text": " 󰈀 ", "class": "connected"}'

    [[ $prev_state != connected  ]] && ( notify-send "Internet" "Connected to $(iwgetid -r || echo network)" & echo "connected" > /tmp/prev-connection-state ) || true

    exit
else
    echo '{"text": " 󰛵 ", "class": "disconnected"}'
fi
