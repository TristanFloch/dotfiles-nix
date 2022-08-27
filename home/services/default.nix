{ config, lib, pkgs, ... }:

{
  imports = [ ./wlsunset ];

  services = {
    network-manager-applet.enable = true;
    blueman-applet.enable = true;
  };
}
