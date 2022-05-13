{ options, config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.desktop.sessions.x;
in
{
  options.modules.desktop.sessions.x.enable = mkEnableOption "X session";

  imports = [
    ./i3
    ./xmonad
  ];

  config = mkIf cfg.enable {
    xsession.enable = true;
    xresources.properties = { "Xft.dpi" = "96"; };
  };
}
