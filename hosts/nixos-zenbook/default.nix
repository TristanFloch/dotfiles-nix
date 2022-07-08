{ config, lib, pkgs, ... }:

let
  commonOptions = {
    modules.desktop.sessions = {
      x.enable = false; # defaults to i3 + polybar
      wayland = {
        enable = true;
        sway.enable = false;
        hyprland.enable = true;
      };
    };
  };

  homeManagerOptions.modules = {
    dev = {
      cc.enable = true;
      python.enable = true;
    };
  };
in {
  imports = [ ./hardware-configuration.nix ../configuration.nix ../home.nix ];

  networking.hostName = "nixos-zenbook";

  # custom nixos options
  modules = commonOptions.modules;

  # custom home manager options
  home-manager.users.tristan.modules = commonOptions.modules
    // homeManagerOptions.modules;
}
