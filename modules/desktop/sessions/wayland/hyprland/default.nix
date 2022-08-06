{ options, config, lib, pkgs, ... }:

let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.modules.desktop.sessions.wayland.hyprland;
in {
  options.modules.desktop.sessions.wayland.hyprland.enable =
    mkEnableOption "Hyprland";

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      package = null; # use the home manager module instead
    };

    security.pam.services.swaylock = { };

    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${pkgs.hyprland}/bin/Hyprland";
          user = "tristan";
        };

        default_session = initial_session;
      };
    };
  };
}
