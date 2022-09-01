{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  xsession = config.modules.desktop.sessions.x;
  cfg = config.modules.desktop.apps.launchers.rofi;
in {
  options.modules.desktop.apps.launchers.rofi.enable =
    (mkEnableOption "Rofi launcher") // {
      default = xsession.enable;
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

    modules.desktop.apps.launchers.cmd =
      "${pkgs.rofi}/bin/rofi -modi drun -show drun";

    xdg.configFile = {
      "rofi/colors.rasi".source = ./colors.rasi;
      "rofi/powermenu.sh".source = ./powermenu.sh;
      "rofi/powermenu.rasi".source = ./powermenu.rasi;
    };
  };
}
