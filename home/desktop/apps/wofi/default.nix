{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  wayland = config.modules.desktop.sessions.wayland;
  wofi = config.modules.desktop.apps.wofi;
in
{
  options.modules.desktop.apps.wofi.enable = mkEnableOption "Wofi launcher";

  config = mkIf (wayland.enable && wofi.enable) {
    home.packages = with pkgs; [
      wofi
    ];

    home.file.".config/wofi/style.css".source = ./style.css;
  };
}
