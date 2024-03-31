#!/usr/bin/env bash

for display in $(hyprctl -j monitors all | jq -r '.[].name')
do
    displays+=( $display )
done

# displays=(eDP-1 HDMI-A-1)

option=$(echo "${displays[0]} only
${displays[1]} only
Mirror
${displays[0]} left of ${displays[1]}
${displays[1]} left of ${displays[0]}" | rofi -dmenu -p "Choose display configuration")

if [ "$option" == "${displays[0]} only" ]
then
	hyprctl --batch "keyword monitor ${displays[0]},prefered,0x0,1 ; keyword monitor ${displays[1]},prefered,1920x0,1 ; keyword monitor ${displays[1]},disable"
elif [ "$option" == "${displays[1]} only" ]
then
	hyprctl --batch "keyword monitor ${displays[1]},prefered,0x0,1 ; keyword monitor ${displays[0]},prefered,1920x0,1 ; keyword monitor ${displays[0]},disable"
elif [ "$option" == "${displays[0]} left of ${displays[1]}" ]
then
	hyprctl --batch "reload; keyword monitor ${display[0]},1920x1080,0x0,1; keyword monitor ${display[1]},1920x1080,1920x0,1;"
elif [ "$option" == "${displays[1]} left of ${displays[0]}" ]
then
	hyprctl --batch "reload; keyword monitor ${display[1]},1920x1080,0x0,1; keyword monitor ${display[0]},1920x1080,1920x0,1;"
fi
