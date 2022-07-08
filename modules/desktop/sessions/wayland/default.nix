{ options, config, lib, pkgs, ... }:

let inherit (lib) mkEnableOption;
in {
  options.modules.desktop.sessions.wayland.enable = mkEnableOption "Wayland";

  imports = [ ./sway ./hyprland ];
}
