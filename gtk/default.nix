{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    dracula-theme
  ];

  gtk = {
    enable = true;
    theme.name = "Dracula";
    iconTheme.name = "Dracula";
    font = {
      name = "Ubuntu";
      size = 11;
    };
  };

  xsession.pointerCursor = {
    package = pkgs.xorg.xcursorthemes;
    name = "Dracula-cursors";
    size = 16;
  };

  home.file = {
    ".icons".source = ./icons;
    ".icons".recursive = true;
  };
}
