{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  wayland = config.modules.desktop.sessions.wayland;
  wofi = config.modules.desktop.apps.launchers.wofi;
in {
  options.modules.desktop.apps.launchers.wofi.enable =
    mkEnableOption "Wofi launcher";

  config = mkIf (wayland.enable && wofi.enable) {
    home.packages = with pkgs; [ wofi ];

    xdg.configFile."wofi/style.css".source = ./style.css;
  };
}
