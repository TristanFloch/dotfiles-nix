{ config, lib, pkgs, ... }:

{
  services.polybar = {
    enable = true;
    override = {
      i3GapsSupport = true;
      alsaSupport = true;
    };
    config = ./config;
    script = builtins.readFile ./launch.sh;
  };
}
