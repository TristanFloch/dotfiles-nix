{ config, lib, pkgs, ... }:

{
  services.polybar = {
    enable = true;
    config = ./config;
    script = builtins.readFile ./launch.sh;
    package = pkgs.polybar.override {
      i3GapsSupport = true;
      alsaSupport = true;
    };
  };
}
