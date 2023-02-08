#!/bin/sh

STATUS=$(nmcli g | tail -n 1 | awk '{print $1}')

if [ "$STATUS" = "disconnected" ]; then
    ICON="󰤮"
    SSID="Disconnected"
else
    SSID=$(nmcli -t -f NAME connection show --active | head -n1 | sed 's/\"/\\"/g')
    SIGNAL=$(nmcli -f in-use,signal dev wifi | rg "\*" | awk '{ print $2 }')
    LEVEL=$(awk -v n="$SIGNAL" 'BEGIN{print int((n-1)/20)}')
    if [ "$LEVEL" = "0" ]; then
        ICON="󰤯"
    elif [ "$LEVEL" = "1" ]; then
        ICON="󰤟"
    elif [ "$LEVEL" = "2" ]; then
        ICON="󰤢"
    elif [ "$LEVEL" = "3" ]; then
        ICON="󰤥"
    else
        ICON="󰤨"
    fi
    # ICON="直"
fi

printf '{ "ssid": "%s", "icon": "%s", "status": "network-%s" }' "$SSID" "$ICON" "$STATUS"
