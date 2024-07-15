{ config, lib, pkgs, ... }:

{
  programs.atuin = {
    enable = true;
    package = pkgs.unstable.atuin;
    enableFishIntegration = config.programs.fish.enable;
    enableBashIntegration = true;
    flags = [ "--disable-up-arrow" ];
  };
}
