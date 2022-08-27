#!/bin/sh

uptime=$(uptime | sed -e 's/[^u]*up[ ]*\([^,]*\),[^$]*/\1/g')
wm="$XDG_CURRENT_DESKTOP"

rofi_command="rofi -theme ~/.config/rofi/powermenu.rasi"

# Options
shutdown=""
reboot=""
lock=""
suspend=""
logout=""

# Variable passed to rofi
options="$suspend\n$logout\n$lock\n$shutdown\n$reboot"

chosen="$(echo -e "$options" | $rofi_command -p "    $uptime" -dmenu -selected-row 2)"
case $chosen in
    "$shutdown")
        systemctl poweroff
        ;;
    "$reboot")
        systemctl reboot
        ;;
    "$lock")
        if [ $wm = "sway" ]; then
            swaylock
        else
            betterlockscreen --lock blur --off 30
        fi
        ;;
    "$suspend")
        mpc -q pause
        amixer set Master mute
        systemctl suspend
        ;;
    "$logout")
        if [ $wm = "sway" ]; then
            swaymsg exit # TODO check if this actually works
        else
            i3-msg exit
        fi
        ;;
esac
