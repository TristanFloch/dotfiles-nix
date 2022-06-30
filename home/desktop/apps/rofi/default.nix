{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.desktop.apps.rofi;
in {
  options.modules.desktop.apps.rofi.enable = (mkEnableOption "Rofi launcher")
    // {
      default = true;
    };

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;

      terminal = "${pkgs.alacritty}/bin/alacritty";
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
  };
}
