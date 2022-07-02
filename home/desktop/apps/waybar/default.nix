{ config, lib, pkgs, ... }:

let
  # TODO change for a sway option
  wayland = config.modules.desktop.sessions.wayland;
in {
  config = lib.mkIf wayland.enable {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      style = ./style.css;
      settings = let
        icon = symbol: color: size:
          "<span font_desc='Ubuntu Nerd Font ${
            builtins.toString size
          }' foreground='${color}'>${symbol}</span>";

        swaymsg = "${pkgs.sway}/bin/swaymsg";
        playerctl = "${pkgs.playerctl}/bin/playerctl";
      in {
        mainBar = {
          position = "bottom";
          spacing = 0;
          height = 38;
          modules-left = [
            "custom/window-icon"
            "sway/window"
            "custom/sway-scratch"
            "custom/clock-icon"
            "clock"
            "keyboard-state"
            "custom/spotify"
            "custom/spotify-prev"
            "custom/spotify-next"
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

          "sway/window" = rec {
            format = "{}"; # TODO
            max-length = 30;
            on-click = "${pkgs.rofi}/bin/rofi -modi drun -show drun";
            on-click-right = on-click;
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
              "default" = "";
            };
          };

          "battery" = {
            states = {
              warning = 25;
              critical = 10;
            };
            format = "{icon}     {capacity}%";
            format-time = "{H}h {M}min";
            format-charging = "${icon "" "#50fa7b" 10}     {capacity}%";
            format-icons = [
              (icon "" "#ff5555" 10)
              (icon "" "#ffb86c" 10)
              (icon "" "#f1fa8c" 10)
              (icon "" "#f1fa8c" 10)
              (icon "" "#50fa7b" 10)
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
            on-click-right = "${pkgs.alacritty}/bin/alacritty -e ${pkgs.htop}/bin/htop";
          };

          "custom/memory-icon" = {
            format = "力";
            tooltip = false;
          };

          "memory" = {
            format = "{used:0.1f}GiB";
            tooltip-format = "{used:0.1f}GiB / {total:0.1f}GiB used";
            on-click-right = "${pkgs.alacritty}/bin/alacritty -e ${pkgs.htop}/bin/htop";
          };

          "backlight" = {
            format = "{icon}    {percent}%";
            format-icons = [
              (icon "" "#6272a4" 12)
              (icon "" "#bd93f9" 12)
              (icon "" "#8be9fd" 12)
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

          "pulseaudio" = let
            ramp = symbols:
              with lib; [
                (icon (elemAt symbols 0) "#50fa7b" 12)
                (icon (elemAt symbols 1) "#50fa7b" 12)
                (icon (elemAt symbols 2) "#f1fa8c" 12)
                (icon (elemAt symbols 3) "#ffb86c" 12)
                (icon (elemAt symbols 4) "#ff5555" 12)
              ];
          in {
            scroll-step = 5;
            format = "{icon}    {volume}%";
            format-muted = "${icon "" "#6272a4" 12}    {volume}%";
            # format-bluetooth =
            #   "{icon}    {volume}%   <span font_desc='Ubuntu Nerd Font 12' foreground='#ff79c6'></span>";
            # format-bluetooth-muted = "";

            # format-source = " {volume}%";
            # format-source-muted = "";

            format-icons = rec {
              headphone = default;
              handsfree = ramp [ "" "" "" "" "" ];
              headset = headphone;
              speaker = ramp [ "蓼" "蓼" "蓼" "蓼" "蓼" ];
              # phone = "";
              # portable = "";
              # car = "";
              default = ramp [ "" "" "" "" "" ];
            };
            on-click = "amixer set Master toggle";
            on-click-right = "${pkgs.pavucontrol}/bin/pavucontrol";
          };

          "keyboard-state" = {
            format = "{icon}";
            capslock = true;
            format-icons = {
              locked = "";
              unlocked = "";
            };
          };

          "custom/sway-scratch" = let
            swayScratch = pkgs.callPackage ./scripts/sway-scratch.nix { };
          in {
            interval = 1;
            return-type = "json";
            format = "{icon}";
            format-icons = {
              none = "";
              one = "";
              many = "";
              unknown = "";
            };
            exec = "${swayScratch}/bin/sway-scratch.sh";
            exec-if = "exit 0";
            on-click = "${swaymsg} scratchpad show";
            on-click-right = "${swaymsg} move window to scratchpad";
            tooltip = false;
          };

          "custom/spotify" =
            let mediaPlayer = pkgs.callPackage ./scripts/mediaplayer.nix { };
            in {
              format = "${icon "" "#1DB954" 13}   {}";
              max-length = 35;
              exec = "${mediaPlayer}/bin/mediaplayer.py 2> /dev/null";
              exec-if = "pgrep spotify";
              return-type = "json";

              on-scroll-up = "${playerctl} --player=spotify position 5+";
              on-scroll-down = "${playerctl} --player=spotify position 5-";
              on-click = "${playerctl} --player=spotify play-pause";
              on-click-right = "${swaymsg} [class=Spotify] focus";
            };

          "custom/spotify-next" = {
            format = "{}";
            interval = 10;
            exec = "echo "; # ﭡ
            exec-if = "pgrep spotify";
            on-click = "${playerctl} --player=spotify next";
            tooltip = false;
          };

          "custom/spotify-prev" = {
            format = "{}";
            interval = 10;
            exec = "echo "; # ﭣ
            exec-if = "pgrep spotify";
            on-click = "${playerctl} --player=spotify previous";
            tooltip = false;
          };

          "sway/mode" = {
            format = "${icon "" "#1e2029" 11}   {}";
          };
        };
      };
    };
  };
}
