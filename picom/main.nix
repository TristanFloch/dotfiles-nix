{ config, lib, pkgs, ... }:

{
  services.picom = {
    enable = true;
    fade = true;
    fadeDelta = 5; #ms
    fadeSteps = [ "0.08" "0.08" ]; #ms
  };
}
