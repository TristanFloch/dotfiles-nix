{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.modules.desktop.sessions.wayland.hyprland;
in {
  options.modules.desktop.sessions.wayland.hyprland.enable =
    mkEnableOption "Hyprland";

  config = mkIf cfg.enable {
    xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
  };
}
