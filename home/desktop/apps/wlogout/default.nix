{ config, lib, pkgs, ... }:

let wayland = config.modules.desktop.sessions.wayland;
in {
  config = lib.mkIf wayland.enable {
    home.packages = with pkgs; [ wlogout ];

    xdg = {
      configFile."wlogout/layout".source = ./layout;
      configFile."wlogout/style.css".source = ./style.css;
      configFile."wlogout/icons" = {
        source = ./icons;
        recursive = true;
      };
    };
  };
}
