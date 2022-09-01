{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  wayland = config.modules.desktop.sessions.wayland;
  cfg = config.modules.desktop.apps.launchers.wofi;
in {
  options.modules.desktop.apps.launchers.wofi.enable =
    (mkEnableOption "Wofi launcher") // {
      default = wayland.enable;
    };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ wofi ];

    xdg.configFile."wofi/style.css".source = ./style.css;
    xdg.configFile."wofi/config".source = ./config;

    modules.desktop.apps.launchers.cmd = "${pkgs.wofi}/bin/wofi";
  };
}
