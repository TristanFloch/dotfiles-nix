#!/bin/sh

POWERED=$(bluetoothctl show | rg Powered | cut -f 2- -d ' ')

if [ "$POWERED" = "yes" ]; then
    STATUS=$(bluetoothctl info)
    NAME=$(echo "$STATUS" | rg Name | cut -f 2- -d ' ')
fi

printf '{ "powered": "%s", "name": "%s" }\n' "$POWERED" "$NAME"
