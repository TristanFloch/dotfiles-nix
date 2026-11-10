{ config, pkgs, ... }:
{
  programs.direnv = {
    enable = true;
    package = pkgs.unstable.direnv;
    nix-direnv.enable = true;
  };
}
