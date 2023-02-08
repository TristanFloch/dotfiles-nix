#!/bin/sh

compute() {
    MAX=$(brightnessctl max)
    CURR=$(brightnessctl get)

    NB_ICONS=11
    SCALE=$((CURR * NB_ICONS / MAX))

    if [ "$SCALE" = "0" ]; then
        ICON="󰛩"
    elif [ "$SCALE" = "1" ]; then
        ICON="󱩎"
    elif [ "$SCALE" = "2" ]; then
        ICON="󱩏"
    elif [ "$SCALE" = "3" ]; then
        ICON="󱩐"
    elif [ "$SCALE" = "4" ]; then
        ICON="󱩑"
    elif [ "$SCALE" = "5" ]; then
        ICON="󱩒"
    elif [ "$SCALE" = "6" ]; then
        ICON="󱩓"
    elif [ "$SCALE" = "7" ]; then
        ICON="󱩔"
    elif [ "$SCALE" = "8" ]; then
        ICON="󱩕"
    elif [ "$SCALE" = "9" ]; then
        ICON="󱩖"
    else
        ICON="󰛨"
    fi

    PERCENT=$(brightnessctl -m i | sed 's/[a-zA-Z0-9_]*,[a-zA-Z0-9_]*,[0-9]*,\([0-9]*\)%,[0-9]*/\1/g')

    printf '{ "percent": %s, "icon": "%s" }\n' "$PERCENT" "$ICON"
}

compute

udevadm monitor | rg --line-buffered "backlight" | while read -r _; do
    compute
done
