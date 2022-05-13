{ options, config, lib, pkgs, ... }:

{
  options.modules.desktop.sessions.wayland.enable = lib.mkEnableOption "Wayland";

  imports = [ ./sway ];
}
