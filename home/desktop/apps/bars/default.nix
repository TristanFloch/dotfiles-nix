{ config, lib, pkgs, ... }:

let inherit (lib) types mkOption;
in {
  imports = [ ./waybar ./polybar ./eww ];

  options.modules.desktop.apps.bars.cmd = mkOption {
    type = types.str;
    default = "";
    description = "Start status bar command";
  };
}
