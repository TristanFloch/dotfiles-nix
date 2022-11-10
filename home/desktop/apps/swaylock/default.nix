{ config, lib, pkgs, ... }:

let
  wayland = config.modules.desktop.sessions.wayland;
  colors = config.modules.theme.colors // { transparent = "#00000000"; };
in {
  config = lib.mkIf wayland.enable {
    programs.swaylock.settings = {
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
