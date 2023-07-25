{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    ./global

    ./features/cli
    ./features/vim
  ];
}
