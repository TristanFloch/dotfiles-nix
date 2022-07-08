{ options, config, lib, pkgs, ... }:

let inherit (lib) mkEnableOption mkIf;
in {
  options.modules.desktop.sessions.wayland.enable = mkEnableOption "Wayland";

  imports = [ ./sway ./hyprland ];
}
