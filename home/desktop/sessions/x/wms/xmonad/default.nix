{ options, config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.desktop.sessions.x.wms.xmonad;
in
{
  options.modules.desktop.sessions.x.wms.xmonad.enable =
    mkEnableOption "xmonad";

  config = mkIf cfg.enable {
    xsession.windowManager.xmonad = {
      enable = false;
      enableContribAndExtras = true;
      config = ./xmonad.hs;
      extraPackages = haskellPackages: [
        haskellPackages.dbus
      ];
    };
  };
}
