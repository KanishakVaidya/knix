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
	text=" 󰝟 Mute "
	icon="󰝟"
	notify-send -t 1000 -a 'wp-vol' "Volume" "󰝟 Mute%"
elif [[ vol -lt 30  ]]; then
	icon=""
	notify-send -t 1000 -a 'wp-vol' -h int:value:$((3 * vol / 4)) "Volume" "  ${vol}%"
elif [[ vol -lt 60  ]]; then
	icon=""
	notify-send -t 1000 -a 'wp-vol' -h int:value:$((3 * vol / 4)) "Volume" "  ${vol}%"
elif [[ vol -lt 101  ]]; then
	icon=""
	notify-send -t 1000 -a 'wp-vol' -h int:value:$((3 * vol / 4)) "Volume" "  ${vol}%"
else
	icon=""
	notify-send -u critical -t 1000 -a 'wp-vol' -h int:value:$(((vol + 200) / 4)) "Volume" "  ${vol}%"
fi

if [ -z ${text+x} ]; then
    text=" $icon $vol%"
fi

echo "{\"text\": \"$text\", \"icon\": \"$icon\", \"percentage\": \"$vol\" }"
