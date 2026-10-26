#!/usr/bin/env bash

shutdown='󰐥'
reboot='󰜉'
lock='󰌾'
suspend='󰒲'
logout='󰍃'
yes=''
no=''

option=$(echo -e "$shutdown\n$reboot\n$lock\n$logout\n$suspend" | rofi \
    -dmenu -theme ~/.config/niri/widgets/powermenu/style-5.rasi \
    -hover-select -me-select-entry '' \
    -me-accept-entry MousePrimary \
    -position southwest \
    -click-to-exit
)

case $option in
    $shutdown) poweroff;;
    $reboot) reboot;;
    $lock) $LOCK_COMMAND;;
    $logout) $LOGOUT_COMMAND;;
    $suspend) systemctl hybrid-sleep;;
esac
