{ config, lib, pkgs, ... }:

{
  imports = [
    ./config
    ./desktop
    ./dev
    ./editors
    ./hardware
    ./services
    ./shell
    ./themes
  ];
}
