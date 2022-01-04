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


  home.packages = with pkgs; [
    playerctl
  ];

  home.file = {
    ".config/polybar/colors.ini".source = ./colors.ini;
    ".config/polybar/modules.ini".source = ./modules.ini;
    ".config/polybar/fonts.ini".source = ./fonts.ini;
    ".config/polybar/scripts" = {
      source = ./scripts;
      recursive = true;
    };
  };
}
