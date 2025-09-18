#!/usr/bin/env bash

option=$(echo -e "Logout\nSwitch User\nPowerOff\nReboot" | rofi -dmenu)

case $option in
    "Logout")
	hyprctl dispatch exit ;;
    "Switch User")
	# Switch User
    ;;
    "PowerOff")
	poweroff ;;
    "Reboot")
	reboot ;;
esac
