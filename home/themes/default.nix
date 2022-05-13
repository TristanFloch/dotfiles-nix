{ config, lib, pkgs, ... }:

let
  xsession = config.modules.desktop.sessions.x;
in
{
  imports = [
    ./gtk
  ];

  config = lib.mkIf xsession.enable {
    xsession.pointerCursor = {
      package = pkgs.xorg.xcursorthemes;
      name = "Dracula-cursors";
      size = 16;
    };
  };
}
