#!/bin/sh

BARNAME=main

killall -rq 'polybar'

# if [ "$(systemctl --user status polybar.service)" -ne 0 ]; then
#     systemctl --user stop polybar.service
# fi

ln -sf ~/.config/nixpkgs/polybar/config.ini ~/.config/polybar/config
ln -sf ~/.config/nixpkgs/polybar/modules.ini ~/.config/polybar/modules.ini
ln -sf ~/.config/nixpkgs/polybar/colors.ini ~/.config/polybar/colors.ini
ln -sf ~/.config/nixpkgs/polybar/fonts.ini ~/.config/polybar/fonts.ini

for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload "$BARNAME" -c ~/.config/polybar/config &
done
