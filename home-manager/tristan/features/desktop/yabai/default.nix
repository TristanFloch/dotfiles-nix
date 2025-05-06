{ config, lib, pkgs, ... }:

{
  xdg.configFile = {
    "yabai/yabairc".source = ./yabairc;
    "skhd/skhdrc".source = ./skhdrc;
  };
}
