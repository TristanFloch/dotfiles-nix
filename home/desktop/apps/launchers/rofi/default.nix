{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf optionalString;
  xsession = config.modules.desktop.sessions.x;
  theme = config.modules.theme.name;
  cfg = config.modules.desktop.apps.launchers.rofi;
in {
  options.modules.desktop.apps.launchers.rofi.enable =
    (mkEnableOption "Rofi launcher") // {
      default = xsession.enable;
    };

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      package = if xsession.enable then pkgs.rofi else pkgs.rofi-wayland;
      terminal = "${pkgs.alacritty}/bin/alacritty";
      theme = ./launcher.rasi;
    };

    modules.desktop.apps.launchers.cmd = "${pkgs.rofi}/bin/rofi -show drun"
      + optionalString (!xsession.enable) " -normal-window";

    xdg.configFile = {
      "rofi/colors.rasi".source = ./${theme}.rasi;
      "rofi/powermenu.sh".source = ./powermenu.sh;
      "rofi/powermenu.rasi".source = ./powermenu.rasi;
    };
  };
}
