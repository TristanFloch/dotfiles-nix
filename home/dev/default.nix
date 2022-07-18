{ config, lib, pkgs, ... }:

{
  imports = [ ./cc ./python ./tex ];

  home.packages = with pkgs; [ cached-nix-shell ];
}
