{ config, lib, pkgs, ... }:

{
  services.polybar = {
    enable = true;
    package = pkgs.polybarFull;
    config = ./config.ini;
    script = ''
      for m in $(polybar --list-monitors | ${pkgs.coreutils}/bin/cut -d":" -f1); do
        MONITOR=$m polybar main &
      done
    '';
  };

  home.file.".config/polybar/colors.ini".source = ./colors.ini;
  home.file.".config/polybar/modules.ini".source = ./modules.ini;
}
