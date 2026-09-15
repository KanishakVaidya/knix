#!/usr/bin/env bash

char_icon=("󱟧" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅")
disc_icon=("󱃍" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")

classes=("critical" "gt1" "gt2" "gt3" "gt4" "gt5" "gt6" "gt7" "gt8" "gt9" "gt0")

notification() {
	lines=(
		"Time to roll out the hamster wheel generator!"
		"<whispering> Feed me or face the consequences!"
		"Mayday! Mayday! We are experiencing turbulence."
		"Time to panic or find the nearest outlet!"
		"I'm on a diet, urgently needs a charge!"
		"going on a strike until further notice."
		"Houston, we have a problem!"
		"Crisis mode: Send emergency electrons ASAP!"
		"Time to power up or prepare for hibernation!"
		"flirting with darkness. Send backup (or charger)."
	)
    len=${#lines[@]}
    random_index=$((RANDOM % len))
    random_line=${lines[$random_index]}
    echo "$random_line"
}


stat=$(cat /sys/class/power_supply/BAT0/status)
levl=$(cat /sys/class/power_supply/BAT0/capacity)

case $stat in
	Full)
	    icon="󰂄"
	    ;;
	Charging)
	    icon="${char_icon[0]}"
	    class="charging"
	    for i in {1..10}
	    do
		if [[ $levl == $i? ]]
		then
		    icon="${char_icon[$i]}"
		fi
	    done
	    ;;
	Discharging)
	    if [[ levl -lt 5 ]]; then
		notify-send -u critical "󰄌 Battery $levl%" "Khud e utha jana ab mene ek minute ke andar. shutdown -c hi bcha skta tujhe ab" -a BATTERY -t 30000
		systemctl hybrid-sleep
	    elif [[ levl -lt 25  ]]; then
		notify-send -u critical "󰄌 Battery $levl%" "$(notification)" -a BATTERY -t 30000
	    fi
            icon="${disc_icon[0]}"
	    class="${classes[0]}"
	    for i in {1..10}
	    do
	    	if [[ $levl == $i? ]]
	    	then
	    	    icon="${disc_icon[$i]}"
	    	    class="${classes[$i]}"
	    	fi
	    done
	    ;;
	"Not charging")
	    icon="󰂏";;
	*)
	    icon="󰂑 ??? " ;;
esac
text=" $icon $levl%"
echo "{\"text\": \"$text\" , \"percentage\": \"$levl\", \"icon\": \"$icon\", \"class\": \"$class\" }"
