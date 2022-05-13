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

  home.file = {
    ".icons".source = ./icons;
    ".icons".recursive = true;
  };
}
