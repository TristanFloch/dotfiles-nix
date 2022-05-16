{ config, lib, pkgs, ... }:

{
  services = {
    network-manager-applet.enable = true;
    blueman-applet.enable = true;
  };
}
