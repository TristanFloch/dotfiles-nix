{ config, lib, pkgs, ... }:

let inherit (lib) types mkOption;
in {
  imports = [ ./rofi ./wofi ];

  options.modules.desktop.apps.launchers.cmd = mkOption {
    type = types.str;
    default = "${pkgs.rofi}/bin/rofi -modi drun -show drun";
    description = "Launcher line";
  };
}
