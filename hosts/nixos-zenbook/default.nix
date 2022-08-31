{ config, lib, pkgs, ... }:

let
  commonOptions = {
    modules.desktop.sessions = {
      x.enable = true; # defaults to i3 + polybar
      wayland.enable = false; # defaults to sway + waybar
    };
  };

  homeManagerOptions.modules = {
    editors.helix.enable = true;
    # FIXME
    # desktop.apps.launchers = {
    #   rofi.enable = true;
    # };
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
