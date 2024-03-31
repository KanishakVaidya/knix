#! /usr/bin/env bash

WALLPDIR="$XDG_DATA_HOME/backgrounds/"
for disp in $(hyprctl -j monitors | jq -r ".[].name")
do
    img=$(ls $WALLPDIR | sort -R | head -n 1)
    swaybg -o $disp -i $WALLPDIR/$img -m fill &
    # swaybg -o $disp -i $WALLPDIR/000.jpg -m fill &
done
