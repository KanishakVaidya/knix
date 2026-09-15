#! /usr/bin/env bash

# In case /sys/class/.../backlight file does not have proper permission
# follow this link https://unix.stackexchange.com/a/593121
# but add following udev rule
# ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl0", RUN+="/bin/chmod a+w /sys/class/backlight/%k/brightness"

if [ -z ${BLOCK_BUTTON+x} ]; then
    BLOCK_BUTTON=$1
fi

brand=$(ls /sys/class/backlight/ | head -n 1)

max_brightness=$(cat /sys/class/backlight/$brand/max_brightness)
min_brightness=$(expr $max_brightness \/ 12)
brightness=$(cat /sys/class/backlight/$brand/brightness)
step=$(expr $max_brightness \/ 51)

case $BLOCK_BUTTON in
	4|"up")
		if (( brightness + step < max_brightness )); then
			expr $brightness \+ $step > /sys/class/backlight/$brand/brightness ;
		fi
	;;
	5|"down")
		if [[ $brightness -gt $min_brightness ]]; then
			expr $brightness \- $step > /sys/class/backlight/$brand/brightness ;
		fi
	;;
esac

brightness=$(cat /sys/class/backlight/$brand/brightness)
icon=""
text="$icon $brightness"
percentage=$(expr $brightness \* 100 \/ $max_brightness)

echo "{\"text\": \"$text\" , \"percentage\": \"$percentage\", \"icon\": \"$icon\", \"brightness\": \"$brightness\" }"
# awk '{print "  " $1 " "}' /sys/class/backlight/$brand/brightness
