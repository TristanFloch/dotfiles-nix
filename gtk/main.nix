{ config, pkgs, ... }:

{
  gtk = {
    enable = true;
    theme.name = "Dracula";
    iconTheme.name = "Dracula";
  };

  home.file = {
    ".icons".source = ./icons;
    ".icons".recursive = true;
  };
}

