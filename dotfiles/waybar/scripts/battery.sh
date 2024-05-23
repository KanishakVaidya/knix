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
	Full) text="󰂄 $levl%" ;;
	Charging)
        text=" ${char_icon[0]} $levl% "
		class="charging"
		for i in {1..10}
		do
			if [[ $levl == $i? ]]
			then
				text=" ${char_icon[$i]} $levl% "
			fi
		done
	;;
	Discharging)
		if [[ levl -lt 5 ]]; then
            notify-send -u critical "󰄌 Battery $levl%" "Khud e utha jana ab mene ek minute ke andar. shutdown -c hi bcha skta tujhe ab" -a BATTERY -t 30000
			shutdown now
		elif [[ levl -lt 25  ]]; then
			notify-send -u critical "󰄌 Battery $levl%" "$(notification)" -a BATTERY -t 30000
		fi
        text=" ${disc_icon[0]} $levl% "
		class="${classes[0]}"
		for i in {1..10}
		do
			if [[ $levl == $i? ]]
			then
				text=" ${disc_icon[$i]} $levl% "
				class="${classes[$i]}"
			fi
		done
	;;
	"Not charging") text=" 󰂏 $levl% ";;
    *) text="󰂑 ??? " ;;
esac

echo "{\"text\": \"$text\" , \"class\": \"$class\" }"
