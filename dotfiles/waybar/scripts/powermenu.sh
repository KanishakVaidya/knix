#!/usr/bin/env bash

option=$(echo "Logout\nSwitch User\nPowerOff\nReboot" | rofi -drun)

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
