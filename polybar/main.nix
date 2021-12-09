{ config, lib, pkgs, ... }:

{
  services.polybar = {
    enable = true;
    config = ./config;
    script = ''
      MONITOR=eDP polybar mainbar-i3 -c ~/.config/polybar/config &
      MONITOR=HDMI-A-0 polybar mainbar-i3 -c ~/.config/polybar/config &
    '';
    package = pkgs.polybar.override {
      i3GapsSupport = true;
      alsaSupport = true;
    };
  };
}
