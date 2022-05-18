{ config, pkgs, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };

    iconTheme = { name = "Dracula"; };

    font = {
      name = "Ubuntu";
      size = 11;
    };
  };

  # home.file.".icons".source = pkgs.fetchzip {
  #   url = "https://github.com/dracula/gtk/files/5214870/Dracula.zip";
  #   sha256 = "sha256-rcSKlgI3bxdh4INdebijKElqbmAfTwO+oEt6M2D1ls0=";
  # };

  home.file = {
    ".icons".source = ./icons;
    ".icons".recursive = true;
  };
}
