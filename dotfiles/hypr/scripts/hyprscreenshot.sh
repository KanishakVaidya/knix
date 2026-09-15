#!/usr/bin/env bash

option=$1

case $option in
    "screen")
	hyprshot --mode active --mode output --output-folder ~/pic/screenshots
	;;
    "full")
	for display in $(hyprctl -j monitors all | jq -r '.[].name')
	do
	    hyprshot --mode $display --mode output --output-folder ~/pic/screenshots
	done
	;;
    "area")
	hyprshot --mode region --raw | swappy -f -
	;;
    "window")
	hyprshot --mode window --output-folder ~/pic/screenshots
	;;
esac


