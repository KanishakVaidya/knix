#!/usr/bin/env bash

eww kill

eww open bar

myvol=$(~/.config/waybar/scripts/volume.sh)
brightness=$(~/.config/waybar/scripts/amd_bl.sh)

eww update myvol="$myvol" brightness="$brightness"
