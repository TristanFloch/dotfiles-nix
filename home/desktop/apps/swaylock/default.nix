{ config, lib, pkgs, ... }:

let wayland = config.modules.desktop.sessions.wayland;
in {
  config = lib.mkIf wayland.enable {
    programs.swaylock.settings = let
      colors = {
        background-dark = "#1e2029";
        background = "#282a36";
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
    in {
      font = "Ubuntu";
      font-size = 13;
      image = "~/Pictures/IMG_1043.jpg";
      scaling = "fill";
      daemonize = true;
      show-keyboard-layout = true;
      indicator-radius = 60;
      indicator-thickness = 7;

      line-color = "${colors.background-dark}";
      key-hl-color = "${colors.pink}";
      bs-hl-color = "${colors.orange}";

      inside-color = "${colors.purple}";
      inside-ver-color = "${colors.comment}";
      inside-wrong-color = "${colors.red}";
      inside-clear-color = "${colors.yellow}";
      inside-caps-lock-color = "${colors.cyan}";

      ring-color = "${colors.background-dark}";
      ring-clear-color = "${colors.background-dark}";
      ring-wrong-color = "${colors.background-dark}";
      ring-ver-color = "${colors.background-dark}";

      text-color = "${colors.background-dark}";
      text-caps-lock-color = "${colors.background-dark}";
      text-wrong-color = "${colors.background-dark}";
      text-ver-color = "${colors.background-dark}";

      layout-bg-color = "${colors.transparent}";
      layout-text-color = "${colors.background-dark}";
    };
  };
}
