{ config, lib, pkgs, ... }:

let
  inherit (lib) mkOption types;
in {
  imports = [
    ./config
    ./desktop
    ./editors
    ./hardware
    ./services
    ./shell
    ./themes
  ];

  options.home.theme.name = mkOption {
    description = "theme to use cross-config";
    type = types.uniq types.str;
    default = "dracula";
  };
  options.home.theme.variant = lib.mkOption {
    type = types.nullOr types.str;
    default = null;
  };
}
