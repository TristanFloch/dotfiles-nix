{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../configuration.nix
    ../home.nix
  ];

  networking.hostName = "nixos-zenbook";

  modules = {
    desktop = {
      sessions = {
        x.enable = true; # defaults to i3 + polybar
        wayland.enable = false;
      };
    };
  };

  home-manager.users.tristan.modules = {
    desktop = {
      sessions = {
        x.enable = true; # defaults to i3 + polybar
        wayland.enable = false;
      };
    };
  };
}
