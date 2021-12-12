{ config, lib, pkgs, ... }:

{
  services.polybar = {
    enable = true;
    config = ./config;
    script = ''
      MONITOR=eDP polybar mainbar-i3 &
      MONITOR=HDMI-A-0 polybar mainbar-i3 &
    '';
    package = pkgs.polybar.override {
      i3GapsSupport = true;
      alsaSupport = true;
      iwSupport = true;
    };
  };
}
