#!/usr/bin/env bash

option=$(echo -e "Logout\nSwitch User\nPowerOff\nReboot" | rofi -dmenu)

case $option in
    "Logout")
	exec $LOGOUT_COMMAND ;;
    "Switch User")
	dm-tool switch-to-greeter ;;
    "PowerOff")
	poweroff ;;
    "Reboot")
	reboot ;;
esac
