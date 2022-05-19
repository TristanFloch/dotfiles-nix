{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf;
  # TODO change for a sway option
  wayland = config.modules.desktop.sessions.wayland;
in
{
  config = lib.mkIf wayland.enable {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          spacing = 2;
          height = 36;
          output = [
            "eDP"
            "HDMI-A-0"
          ];
          modules-left = [ "sway/workspaces" "sway/mode" ];
          modules-center = [ "sway/window" ];
          modules-right = [ "backlight" "battery" "cpu" "clock" "tray" ];

          "sway/workspaces" = {
            all-outputs = true;
            format = "{icon}";
            format-icons = {
              "0" = "";
              "1" = "";
              "2" = "";
              "3" = "漣";
              "4" = "";
              "5" = "";
              "6" = "";
              "7" = "";
              "default" = "";
            };
          };

          "battery" = {
            format = "{icon} {capacity}%";
            format-icons = [ "" "" "" "" "" ];
          };

          "clock" = {
            format-alt = "{:%a, %d. %b  %H:%M}";
          };

          "cpu" = {
            format = " {usage}%";
            tooltip = false;
          };

          "memory" = {
            format = "力  {}%";
          };

          "backlight" = {
            format = "{icon} {percent}%";
            format-icons = [ "" "" "" ];
          };

          "tray" = {
            # "icon-size" = 21;
            spacing = 10;
          };
        };
      };
    };
  };
}
