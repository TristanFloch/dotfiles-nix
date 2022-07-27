{ config, lib, pkgs, ... }:

{
  imports = [
    ./vim
    ./emacs
    ./helix
  ];
}
