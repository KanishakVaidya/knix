#!/usr/bin/env bash

eww kill

eww open bar

myvol=$(~/.config/waybar/scripts/volume.sh)

eww update myvol="$myvol"
