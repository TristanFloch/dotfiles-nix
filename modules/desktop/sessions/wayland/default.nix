{ options, config, lib, pkgs, ... }:

let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.modules.desktop.sessions.wayland;
in {
  options.modules.desktop.sessions.wayland.enable = mkEnableOption "Wayland";

  imports = [ ./sway ./hyprland ];

  config = mkIf cfg.enable {
    services.dbus.enable = true;
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      gtkUsePortal = true;

      extraPortals = if cfg.hyprland.enable then
        [ pkgs.xdg-desktop-portal-wlr-hyprland ]
      else
        [ pkgs.xdg-desktop-portal-wlr ];
    };
  };
}
