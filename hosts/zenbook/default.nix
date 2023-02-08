{ config, lib, pkgs, ... }:

let
  commonOptions.modules = {
    desktop.sessions = {
      x.enable = false; # defaults to i3 + polybar
      wayland = {
        enable = true;
        sway.enable = true;
        hyprland.enable = false;
      };
    };
  };

  homeManagerOptions.modules = {
    theme = {
      name = "dracula";
      variant = null;
    };
    desktop.apps = {
      launchers = {
        rofi.enable = true;
        wofi.enable = false;
      };
      bars = {
        waybar.enable = false;
        eww.enable = true;
      };
    };
    editors.helix.enable = true;
  };

  nixosOptions.modules = { services.docker.enable = true; };
in {
  imports = [ ./hardware-configuration.nix ../configuration.nix ../home.nix ];

  networking.hostName = "zenbook";

  # custom nixos options
  modules = lib.mkMerge [ commonOptions.modules nixosOptions.modules ];

  # custom home manager options
  home-manager.users.tristan.modules =
    lib.mkMerge [ commonOptions.modules homeManagerOptions.modules ];
}
