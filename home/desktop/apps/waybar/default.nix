{ config, lib, pkgs, ... }:

let
  inherit (lib) optionals;
  wayland = config.modules.desktop.sessions.wayland;
  sway = wayland.sway;
in {
  config = lib.mkIf wayland.enable {
    programs.waybar = {
      enable = true;
      package = if sway.enable then pkgs.waybar else pkgs.waybar-hyprland;
      systemd.enable = true;
      style = ./style.css;
      settings = let
        icon = symbol: color: size:
          "<span font_desc='Ubuntu Nerd Font ${
            builtins.toString size
          }' foreground='${color}'>${symbol}</span>";

        swaymsg = "${pkgs.sway}/bin/swaymsg";
        hyprctl = "${pkgs.hyprland}/bin/hyprctl";
        playerctl = "${pkgs.playerctl}/bin/playerctl";
        brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
        amixer = "${pkgs.alsa-utils}/bin/amixer";
        pgrep = "${pkgs.procps}/bin/pgrep";
        appLauncher = "${pkgs.rofi}/bin/rofi -modi drun -show drun";
      in {
        mainBar = let
          module-workspaces = {
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
        in {
          position = "bottom";
          layer = "top";
          spacing = 0;
          height = 48;
          modules-left = [ "custom/window-icon" ]
            ++ (if sway.enable then [ "sway/window" ] else [ "wlr/taskbar" ])
            ++ [
              "custom/scratchpads"
              "custom/clock-icon"
              "clock"
              "keyboard-state"
              "custom/spotify"
              "custom/spotify-prev"
              "custom/spotify-next"
            ] ++ (if sway.enable then [ "sway/mode" ] else [ ]);
          modules-center =
            if sway.enable then [ "sway/workspaces" ] else [ "wlr/workspaces" ];
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

          "custom/window-icon" = rec {
            format = "";
            tooltip = false;
            on-click = "${appLauncher}";
            on-click-right = on-click;
          };

          "sway/window" = rec {
            format = "{}"; # TODO
            max-length = 30;
            on-click = "${appLauncher}";
            on-click-right = on-click;
          };

          "wlr/taskbar" = {
            format = "{icon}";
            icon-size = 20;
            active-first = true;
            on-click = "activate";
            on-click-middle = "close";
            all-outputs = true;
            ignore-list = [
              "Rofi"
              "Alacritty"
            ];
          };

          "sway/workspaces" = module-workspaces // {
            disable-scroll-wraparound = true;
          };

          "wlr/workspaces" = module-workspaces // { on-click = "activate"; };

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
            on-click-right =
              "${pkgs.alacritty}/bin/alacritty -e ${pkgs.htop}/bin/htop";
          };

          "custom/memory-icon" = {
            format = "力";
            tooltip = false;
          };

          "memory" = {
            format = "{used:0.1f}GiB";
            tooltip-format = "{used:0.1f}GiB / {total:0.1f}GiB used";
            on-click-right =
              "${pkgs.alacritty}/bin/alacritty -e ${pkgs.htop}/bin/htop";
          };

          "backlight" = {
            format = "{icon}    {percent}%";
            format-icons = [
              (icon "" "#6272a4" 12)
              (icon "" "#bd93f9" 12)
              (icon "" "#8be9fd" 12)
            ];
            on-scroll-up = "${brightnessctl} -c backlight set +5%";
            on-scroll-down = "${brightnessctl} -c backlight set 5%-";
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
            on-click = "${amixer} set Master toggle";
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

          "custom/scratchpads" = let
            scratchpadsScript = if sway.enable then
              "${
                pkgs.callPackage ./scripts/sway-scratch.nix { }
              }/bin/sway-scratch.sh"
            else
              "${
                pkgs.callPackage ./scripts/hyprland-special.nix { }
              }/bin/hyprland-special.sh";
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
            exec = "${scratchpadsScript}";
            exec-if = "exit 0";
            tooltip = true;

            on-click = if sway.enable then
              "${swaymsg} scratchpad show"
            else
              "${hyprctl} dispatch togglespecialworkspace uselessArg2";

            on-click-right = if sway.enable then
              "${swaymsg} move window to scratchpad"
            else
              null;

          };

          "custom/spotify" =
            let mediaPlayer = pkgs.callPackage ./scripts/mediaplayer.nix { };
            in {
              format = "${icon "" "#1DB954" 13}   {}";
              max-length = 35;
              exec = "${mediaPlayer}/bin/mediaplayer.py 2> /dev/null";
              exec-if = "${pgrep} spotify";
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
            exec-if = "${pgrep} spotify";
            on-click = "${playerctl} --player=spotify next";
            tooltip = false;
          };

          "custom/spotify-prev" = {
            format = "{}";
            interval = 10;
            exec = "echo "; # ﭣ
            exec-if = "${pgrep} spotify";
            on-click = "${playerctl} --player=spotify previous";
            tooltip = false;
          };

          "sway/mode" = { format = "${icon "" "#1e2029" 11}   {}"; };
        };
      };
    };
  };
}
