{ config, lib, pkgs, ... }:

{
  xdg = {
    configFile."wlogout/layout".source = ./layout;
    configFile."wlogout/style.css".source = ./style.css;
    configFile."wlogout/icons" = {
      source = ./icons;
      recursive = true;
    };
  };
}
