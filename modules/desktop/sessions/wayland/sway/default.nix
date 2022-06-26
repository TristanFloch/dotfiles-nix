{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf;
  cfg = config.modules.desktop.sessions.wayland;
in
{
  config = mkIf cfg.enable {
    programs.sway = {
      enable = true;
    };

    services.dbus.enable = true;
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      # gtk portal needed to make gtk apps happy
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      gtkUsePortal = true;
    };

    environment.loginShellInit = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec sway
      fi
    '';
  };
}
