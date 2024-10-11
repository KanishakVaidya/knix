#!/usr/bin/env bash

keyboard=$(hyprctl -j devices | jq -r '.keyboards[] | select(.main) | .name')

toggle_lang () {
    hyprctl switchxkblayout $keyboard next
}

if [ -z ${BLOCK_BUTTON+x} ]; then
    BLOCK_BUTTON=$1
fi

case $BLOCK_BUTTON in
	1) toggle_lang ;;
    *) ;;
esac

lang=$(hyprctl -j devices | jq -r '.keyboards[] | select(.main) | .active_keymap')

case $lang in
    "English (US)") text="en" ;;
    "Indian") text="in" ;;
    *) text=$land
esac

# Employing a hack to get caps lock state in hyprland for now.
# Reading the state of caps lock led to get caps lock state.
[[ $(cat /sys/class/leds/input15\:\:capslock/brightness) == 1 ]] && capstate="capson"
echo "{\"text\": \"$text\" , \"class\": \"$capstate\" }"
