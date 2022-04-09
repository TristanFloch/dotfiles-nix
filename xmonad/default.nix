{ config, lib, pkgs, ... }:

{
  xsession = {
    enable = true;
    windowManager.xmonad = {
      enable = false;
      enableContribAndExtras = true;
      config = ./xmonad.hs;
      extraPackages = haskellPackages: [
        haskellPackages.dbus
      ];
    };
  };
}
