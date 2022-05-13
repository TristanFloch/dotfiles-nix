{ config, lib, pkgs, ... }:

{
  imports = [
    ./apps
    ./sessions
    ./term
  ];
}
