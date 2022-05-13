{ options, config, lib, pkgs, ... }:

{
  imports = [
    ./config
    ./desktop
    ./editors
    ./hardware
    ./shell
    ./themes
  ];
}
