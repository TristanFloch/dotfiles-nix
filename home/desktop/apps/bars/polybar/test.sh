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
mkdir ~/.config/polybar/scripts
ln -sf ~/.config/nixpkgs/polybar/scripts/polybar_status.py ~/.config/polybar/scripts/polybar_status.py
ln -sf ~/.config/nixpkgs/polybar/scripts/switch_layout.sh ~/.config/polybar/scripts/switch_layout.sh

for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload "$BARNAME" -c ~/.config/polybar/config &
done
