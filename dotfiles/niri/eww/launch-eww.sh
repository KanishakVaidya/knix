#!/usr/bin/env bash

EWW="eww -c $HOME/.config/niri/eww"

${EWW} kill

for display in $(niri msg --json outputs | jq -r 'keys[]')
do
    echo "Opening on $display"
    ${EWW} open bar --arg monitor=$display --screen $display --id $display
done

myvol=$(~/.config/waybar/scripts/volume.sh)
brightness=$(~/.config/waybar/scripts/amd_bl.sh)

${EWW} update myvol="$myvol" brightness="$brightness"
