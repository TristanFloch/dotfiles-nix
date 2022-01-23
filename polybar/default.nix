{ config, lib, pkgs, ... }:

{
  services.polybar =
    let
      colors = {
        background = "#1e2029";
        foreground = "#f8f8f2";
        transparent = "#00000000";
        comment = "#6272a4";
        cyan = "#8be9fd";
        green = "#50fa7b";
        orange = "#ffb86c";
        pink = "#ff79c6";
        purple = "#bd93f9";
        red = "#ff5555";
        yellow = "#f1fa8c";
        black = "#000000";
      };
      fonts = [
        "Ubuntu Nerd Font:size=10.5:style=Book;2"
        "Ubuntu Nerd Font Mono:style=Regular:size=13;3"
        "NotoSans Nerd Font:style=ExtraCondensed:size=20;5"
      ];
    in
    {
      enable = true;
      package = pkgs.polybarFull;
      script = ''
        for m in $(polybar --list-monitors | ${pkgs.coreutils}/bin/cut -d":" -f1); do
          MONITOR=$m polybar main &
        done
      '';
      settings = {
        "global/wm" = {
          margin-top = 0;
          margin-bottom = 0;
        };

        "bar/main" = {
          enable-ipc = true;
          witdh = "100%";
          height = 36;
          radius = 0;
          fixed-center = true;
          bottom = true;
          background = colors.transparent;
          foreground = colors.foreground;
          border-top-size = 0;
          border-bottom-size = 6;
          border-bottom-color = colors.transparent;
          border-left-size = 0;
          border-left-color = colors.transparent;
          border-right-size = 0;
          border-right-color = colors.transparent;
          padding-left = 0;
          padding-right = 0;
          module-margin-left = 0;
          module-margin-right = 0;
          modules-left = "xwindow right left date right left my-xkeyboard right left-spotify spotify right-spotify";
          modules-center = "left i3 right";
          modules-right = "left backlight right left pulseaudio right left memory right left cpu right left filesystem right left temperature right left battery right left";
          font = fonts;
          cursor-click = "pointer";
          cursor-scroll = "ns-resize";
          tray-detached = false;
          tray-position = "right";
          tray-scale = 1;
          tray-background = colors.background;
        };

        "settings" = {
          compositing-background = "source";
          compositing-foreground = "over";
          compositing-overline = "over";
          compositing-underline = "over";
          compositing-border = "over";
          format-foreground = colors.foreground;
          format-background = colors.background;
          pseudo-transparency = false;
        };
      };
    };

  home.packages = with pkgs; [
    playerctl
  ];

  home.file = {
    # ".config/polybar/colors.ini".source = ./colors.ini;
    ".config/polybar/modules.ini".source = ./modules.ini;
    ".config/polybar/fonts.ini".source = ./fonts.ini;
    ".config/polybar/scripts" = {
      source = ./scripts;
      recursive = true;
    };
  };
}
