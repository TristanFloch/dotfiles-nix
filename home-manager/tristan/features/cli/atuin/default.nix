{ config, lib, pkgs, ... }:

{
  programs.atuin = {
    enable = true;
    enableFishIntegration = config.programs.fish.enable;
    enableBashIntegration = true;
  };
}
