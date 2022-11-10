{ config, lib, pkgs, ... }:

let
  colors = config.modules.theme.colors;
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "alacritty";
          style = "Regular";
        };
        bold = {
          family = "alacritty";
          style = "Bold";
        };
        italic = {
          family = "alacritty";
          style = "Italic";
        };
        size = 13.3;
        offset = { x = 0; y = 0; };
      };

      colors = {
        primary = {
          background = colors.background;
          foreground = colors.foreground;
        };
        cursor = {
          text = "CellBackground";
          cursor = "CellForeground";
        };
        vi_mode_cursor = {
          text = "CellBackground";
          cursor = "CellForeground";
        };
        search = {
          matches = {
            foreground = "#44475a";
            background = colors.green;
          };
          focused_match = {
            foreground = "#44475a";
            background = colors.orange;
          };
          footer_bar = {
            background = colors.background;
            foreground = colors.foreground;
          };
        };
        line_indicator = {
          foreground = "None";
          background = "None";
        };
        selection = {
          text = "CellForeground";
          background = "#44475a";
        };
        normal = {
          black = "#000000";
          red = colors.red;
          green = colors.green;
          yellow = colors.yellow;
          blue = colors.purple;
          magenta = colors.pink;
          cyan = colors.cyan;
          white = colors.foreground;
        };
      };
    };
  };
}
