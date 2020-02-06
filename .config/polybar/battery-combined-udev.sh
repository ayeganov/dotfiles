#!/bin/sh

battery_print() {
    path_ac="/sys/class/power_supply/AC"
    path_battery="/sys/class/power_supply/BAT0"

    ac=0
    battery_level=0
    battery_max=1

    if [ -f "$path_ac/online" ]; then
        ac=$(cat "$path_ac/online")
    fi

    if [ -f "$path_battery/charge_now" ]; then
        battery_level=$(cat "$path_battery/charge_now")
    fi

    if [ -f "$path_battery/charge_full" ]; then
        battery_max=$(cat "$path_battery/charge_full")
    fi


    battery_percent=$(($battery_level * 100))
    battery_percent=$(($battery_percent / $battery_max))

    icon=""
    charging=""
    if [ "$ac" -eq 1 ]; then
        if [ "$battery_percent" -gt 97 ]; then
            echo "$charging $icon"
        else
            echo "$charging $icon $battery_percent %"
        fi
    else
        if [ "$battery_percent" -le 10 ]; then
            icon=""
        elif [ "$battery_percent" -le 25 ]; then
            icon=""
        elif [ "$battery_percent" -le 50 ]; then
            icon=""
        elif [ "$battery_percent" -le 75 ]; then
            icon=""
        fi

        echo "$icon $battery_percent %"
    fi
}

path_pid="/home/aleks/.config/polybar/battery-combined-udev.pid"

case "$1" in
    --update)
        pid=$(cat $path_pid)

        if [ "$pid" != "" ]; then
            kill -10 "$pid"
        fi
        ;;
    *)
        echo $$ > $path_pid

        trap exit INT
        trap "echo" USR1

        while true; do
            battery_print

            sleep 3 &
            wait
        done
        ;;
esac
