{ config, lib, pkgs, ... }:

let
  xsession = config.modules.desktop.sessions.x;
in
{
  imports = [
    ./gtk
    ./font
  ];

  config = lib.mkIf xsession.enable {
    home.pointerCursor = {
      package = pkgs.xorg.xcursorthemes;
      name = "Dracula-cursors";
      size = 16;
    };
  };
}
