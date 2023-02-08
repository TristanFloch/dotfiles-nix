#!/bin/sh

status() {
    if [ "$STATE" = "Charging" ]; then
        echo -n "charging"

}

BASEPATH=/sys/class/power_supply/BATT
while true; do
    STATE=$(cat /sys/class/power_supply/BATT/status)

    echo '{ "status": "'"$(STATE)"'" }'
done
