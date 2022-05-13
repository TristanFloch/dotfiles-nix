{ config, lib, pkgs, ... }:

let
  xsession = config.modules.desktop.sessions.x;
in
{
  config = lib.mkIf xsession.enable {
    services.picom = {
      enable = true;
      fade = true;
      fadeDelta = 8; #ms
      fadeSteps = [ "0.08" "0.08" ]; #ms
      shadow = true;
      shadowExclude = [ "window_type *= 'menu'" ];
    };
  };
}
