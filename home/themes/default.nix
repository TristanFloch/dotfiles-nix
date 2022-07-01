{ config, lib, pkgs, ... }:

let xsession = config.modules.desktop.sessions.x;
in {
  imports = [ ./gtk ./font ];

  home.pointerCursor = {
    name = "Dracula-cursors";
    package = pkgs.xorg.xcursorthemes;
    gtk.enable = true;
    x11.enable = xsession.enable;
    size = 16;
  };
}
