#!/bin/sh

layout="$(setxkbmap -print | awk -F"+" '/xkb_symbols/ {print $2}')"

if [ "$layout" = "us" ]; then
    setxkbmap us_intl
    echo ""
else
    setxkbmap us
    echo ""
fi
