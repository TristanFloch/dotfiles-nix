{ options, config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.desktop.sessions.x.xmonad;
in
{
  options.modules.desktop.sessions.x.xmonad.enable =
    mkEnableOption "xmonad";

  config = mkIf cfg.enable {
    services.xserver = {
      displayManager.defaultSession = "none+i3";
      windowManager.xmonad.enable = true;
    };
  };
}
