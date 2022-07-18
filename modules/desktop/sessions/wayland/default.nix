{ options, config, lib, pkgs, ... }:

let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.modules.desktop.sessions.wayland;
  gtk-portal-no-gnome =
    pkgs.xdg-desktop-portal-gtk.override ({ buildPortalsInGnome = false; });
in {
  options.modules.desktop.sessions.wayland.enable = mkEnableOption "Wayland";

  imports = [ ./sway ./hyprland ];

  config = mkIf cfg.enable {
    services.dbus.enable = true;
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      gtkUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        gtk-portal-no-gnome
      ];
    };
  };
}
