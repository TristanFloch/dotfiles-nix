#!/bin/sh

uptime=$(uptime | sed -e 's/[^u]*up[ ]*\([^,]*\),[^$]*/\1/g')

rofi_command="rofi -theme ~/.config/rofi/powermenu.rasi"

# Options
shutdown=""
reboot=""
lock=""
suspend=""
# suspend="⏾"
logout=""

# Variable passed to rofi
options="$suspend\n$logout\n$lock\n$shutdown\n$reboot"

chosen="$(echo -e "$options" | $rofi_command -p "   $uptime" -dmenu -selected-row 2)"
case $chosen in
    "$shutdown")
        systemctl poweroff
        ;;
    "$reboot")
        systemctl reboot
        ;;
    "$lock")
        betterlockscreen --lock blur --off 30
        ;;
    "$suspend")
        mpc -q pause
        amixer set Master mute
        systemctl suspend
        ;;
    "$logout")
        i3-msg exit
        ;;
esac
