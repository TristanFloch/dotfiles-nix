{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf;
  cfg = config.modules.desktop.sessions.wayland;
in
{
  config = mkIf cfg.enable {
    programs.sway = {
      enable = true;
      extraPackages = with pkgs; [ swaylock swayidle ];
    };

    services.dbus.enable = true;
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
      ];
      gtkUsePortal = true;
    };

    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${pkgs.sway}/bin/sway";
          user = "tristan";
        };

        default_session = initial_session;
      };
    };
  };
}
