{ config, lib, pkgs, ... }:

{
  imports = [
    ./config
    ./desktop
    ./editors
    ./hardware
    ./services
    ./shell
    ./themes
  ];
}
