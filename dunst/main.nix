{ config, lib, pkgs, ... }:

{
  services.dunst = {
    enable = true;
    configFile = ./dunstrc;
  };
}
