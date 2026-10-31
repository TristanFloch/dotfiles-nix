{ config, lib, pkgs, ... }:

{
  imports = [
    ./ghostty.nix
    ./rex
  ];
}
