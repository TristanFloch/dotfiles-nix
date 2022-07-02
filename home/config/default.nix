{ config, lib, pkgs, ... }:

{
  imports = [
    ./htop
    ./git
    ./xdg
  ];
}
