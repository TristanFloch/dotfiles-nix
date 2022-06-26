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
      style = ./style.css;
      settings = {
        mainBar = {
          position = "bottom";
          spacing = 0;
          height = 38;
          modules-left = [
            "custom/window-icon"
            "sway/window"
            "custom/clock-icon"
            "clock"
            "sway/mode"
          ];
          modules-center = [ "sway/workspaces" ];
          modules-right = [
            "backlight"
            "pulseaudio"
            "custom/cpu-icon"
            "cpu"
            "custom/memory-icon"
            "memory"
            "custom/disk-icon"
            "disk"
            "custom/temperature-icon"
            "temperature"
            "battery"
            "tray"
          ];

          "custom/window-icon" = {
            format = "";
            tooltip = false;
          };

          "sway/window" = {
            format = "{}"; # TODO
            max-length = 30;
          };

          "sway/workspaces" = {
            all-outputs = false;
            format = "{icon}";
            format-icons = {
              "1" = ""; # 
              "2" = "";
              "3" = "";
              "4" = "";
              "5" = "";
              "6" = "";
              "7" = "";
              "8" = "";
              "default" = "";
            };
          };

          "battery" = {
            states = {
              warning = 25;
              critical = 10;
            };
            format = "{icon}     {capacity}%";
            format-icons = [
              "<span font_desc='Ubuntu Nerd Font 11' foreground='#ff5555'></span>"
              "<span font_desc='Ubuntu Nerd Font 11' foreground='#ffb86c'></span>"
              "<span font_desc='Ubuntu Nerd Font 11' foreground='#f1fa8c'></span>"
              "<span font_desc='Ubuntu Nerd Font 11' foreground='#f1fa8c'></span>"
              "<span font_desc='Ubuntu Nerd Font 11' foreground='#50fa7b'></span>"
            ];
            full-at = 80;
          };

          "custom/clock-icon" = {
            format = "";
            tooltip = false;
          };

          "clock" = {
            format = "{:%d/%m - %H:%M}";
            format-alt = "{:%a, %d. %b %Y - %H:%M:%S}";
          };

          "custom/cpu-icon" = {
            format = "";
            tooltip = false;
          };

          "cpu" = {
            format = "{usage}%";
            tooltip = false;
          };

          "custom/memory-icon" = {
            format = "力";
            tooltip = false;
          };

          "memory" = {
            format = "{used:0.1f}GiB";
            tooltip-format = "{used:0.1f}GiB / {total:0.1f}GiB used";
          };

          "backlight" = {
            format = "{icon}    {percent}%";
            format-icons = [
              "<span font_desc='Ubuntu Nerd Font 12' foreground='#6272a4'></span>"
              "<span font_desc='Ubuntu Nerd Font 12' foreground='#bd93f9'></span>"
              "<span font_desc='Ubuntu Nerd Font 12' foreground='#8be9fd'></span>"
            ];
            on-scroll-up = "brightnessctl -c backlight set +5%";
            on-scroll-down = "brightnessctl -c backlight set 5%-";
          };

          "custom/temperature-icon" = {
            format = "";
            tooltip = false;
          };

          "temperature" = {
              critical-threshold = 80;
              tooltip = false;
          };

          "tray" = {
            # "icon-size" = 21;
            spacing = 10;
          };

          "custom/disk-icon" = {
            format = "";
            tooltip = false;
          };

          "disk" = {
            format = "{free}";
            tooltip-format = "{used} out of {total} used ({percentage_used}%)";
          };

          "pulseaudio" = {
            scroll-step = 1; # %, can be a float
            format = "{icon}    {volume}%";
            format-muted = "<span font_desc='Ubuntu Nerd Font 12' foreground='#6272a4'></span>    {volume}%";
            format-bluetooth = "{icon}    {volume}%";
            format-bluetooth-muted = "";

            # format-source = " {volume}%";
            # format-source-muted = "";

            format-icons = {
              headphones = "";
              handsfree = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = [
                "<span font_desc='Ubuntu Nerd Font 12' foreground='#ffb86c'></span>"
                "<span font_desc='Ubuntu Nerd Font 12' foreground='#ff5555'></span>"
              ];
            };
            on-click = "amixer set Master toggle";
            on-click-right = "${pkgs.pavucontrol}/bin/pavucontrol";
          };
        };
      };
    };
  };
}
