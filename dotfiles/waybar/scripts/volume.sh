#!/usr/bin/env bash

if [ -z ${BLOCK_BUTTON+x} ]; then
    BLOCK_BUTTON=$1
fi
case $BLOCK_BUTTON in
	1) changeto='mute' ;;
    3) changeto='nothing' ; pavucontrol-qt ;;
	4) changeto='increase' ;;
	5) changeto='decrease' ;;
esac
case $changeto in
	'increase')
        pactl set-sink-volume @DEFAULT_SINK@ +1% ;;
	'decrease')
        pactl set-sink-volume @DEFAULT_SINK@ -1% ;;
    'mute') pactl set-sink-mute @DEFAULT_SINK@ toggle ;;
esac

vol=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '/Volume/{print $5+0}')
if [[ $(pactl get-sink-mute @DEFAULT_SINK@) == "Mute: yes" ]]; then
	echo " 󰝟 Mute "
elif [[ vol -lt 30  ]]; then
	echo "  $vol% "
elif [[ vol -lt 60  ]]; then
	echo "  $vol% "
elif [[ vol -lt 101  ]]; then
	echo "  $vol% "
else
	echo "  $vol% "
fi
