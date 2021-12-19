{ config, lib, pkgs, ... }:

{
  services.polybar = {
    enable = true;
    package = pkgs.polybarFull;
    config = ./config;
    script = ''
      for m in $(polybar --list-monitors | ${pkgs.coreutils}/bin/cut -d":" -f1); do
        MONITOR=$m polybar mainbar-i3 &
      done
    '';
  };
}
