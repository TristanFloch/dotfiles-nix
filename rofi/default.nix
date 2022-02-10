{ config, pkgs, ... }:
{
  programs.rofi = {
    enable = true;

    terminal = "alacritty";
    location = "center";

    extraConfig = {
      show-icons = true;
      icon-theme = "Dracula";
      display-drun = "";
      drun-display-format = "{name}";
      sidebar-mode = false;
    };

    theme = ./launcher.rasi;
  };

  home.file.".config/rofi/colors.rasi".source = ./colors.rasi;

  home.file.".config/rofi/powermenu.sh".source = ./powermenu.sh;
  home.file.".config/rofi/powermenu.rasi".source = ./powermenu.rasi;
}
