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
    # FIXME stoped working after update
    home.pointerCursor = {
      package = pkgs.xorg.xcursorthemes;
      name = "Dracula-cursors";
      gtk.enable = true;
      x11.enable = true;
      size = 16;
    };
    gtk.cursorTheme = {
      package = pkgs.xorg.xcursorthemes;
      name = "Dracula-cursors";
      size = 16;
    };
  };
}
