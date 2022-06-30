{ options, config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.desktop.sessions.wayland;
in {
  options.modules.desktop.sessions.wayland.enable = mkEnableOption "Wayland";

  imports = [ ./sway ];
}
