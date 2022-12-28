{ config, lib, pkgs, ... }:

let
  inherit (lib) optionals;
  wayland = config.modules.desktop.sessions.wayland;
  sway = wayland.sway;
  colors = config.modules.theme.colors;
in {
  config = lib.mkIf wayland.enable {
    programs.waybar = {
      enable = true;
      package = if sway.enable then pkgs.waybar else pkgs.waybar-hyprland;
      systemd.enable = sway.enable;
      style = import ./style.nix { inherit colors; };
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
              "clock"
              "keyboard-state"
              "custom/spotify-prev"
              "custom/spotify-next"
              "custom/spotify"
            ] ++ (if sway.enable then [ "sway/mode" ] else [ ]);
          modules-center =
            if sway.enable then [ "sway/workspaces" ] else [ "wlr/workspaces" ];
          modules-right = [
            "backlight"
            "pulseaudio"
            "cpu"
            "memory"
            "disk"
            "temperature"
            "battery"
            "tray"
          ];

          "sway/window" = rec {
            format = "${icon "" colors.purple 13}    {}"; # TODO
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
            ignore-list = [ "Rofi" "Alacritty" ];
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
            format-charging = "${icon "" colors.green 10}     {capacity}%";
            format-icons = [
              (icon "" colors.red 10)
              (icon "" colors.orange 10)
              (icon "" colors.yellow 10)
              (icon "" colors.yellow 10)
              (icon "" colors.green 10)
            ];
            full-at = 80;
          };

          "clock" = {
            format = "${icon "" colors.comment 13}     {:%d/%m - %H:%M}";
            format-alt =
              "${icon "" colors.comment 13}     {:%a, %d. %b %Y - %H:%M:%S}";
          };

          "cpu" = {
            format = "${icon "" colors.cyan 13}    {usage}%";
            on-click-right =
              "${pkgs.alacritty}/bin/alacritty -e ${pkgs.htop}/bin/htop";
          };

          "memory" = {
            format = "${icon "力" colors.pink 12}   {used:0.1f}GiB";
            tooltip-format = "{used:0.1f}GiB / {total:0.1f}GiB used";
            on-click-right =
              "${pkgs.alacritty}/bin/alacritty -e ${pkgs.htop}/bin/htop";
          };

          "backlight" = {
            format = "{icon}    {percent}%";
            format-icons = [
              (icon "" colors.comment 12)
              (icon "" colors.purple 12)
              (icon "" colors.cyan 12)
            ];
            on-scroll-up = "${brightnessctl} -c backlight set +5%";
            on-scroll-down = "${brightnessctl} -c backlight set 5%-";
          };

          "temperature" = {
            format = "${icon "" colors.red 14}    {temperatureC}°C";
            critical-threshold = 80;
            tooltip = false;
          };

          "tray" = {
            # "icon-size" = 21;
            spacing = 10;
          };

          "disk" = {
            format = "${icon "" colors.comment 14}   {free}";
            tooltip-format = "{used} out of {total} used ({percentage_used}%)";
          };

          "pulseaudio" = let
            ramp = symbols:
              with lib; [
                (icon (elemAt symbols 0) colors.green 12)
                (icon (elemAt symbols 1) colors.green 12)
                (icon (elemAt symbols 2) colors.yellow 12)
                (icon (elemAt symbols 3) colors.orange 12)
                (icon (elemAt symbols 4) colors.red 12)
              ];
          in {
            scroll-step = 5;
            format = "{icon}    {volume}%";
            format-muted = "${icon "" colors.comment 12}    {volume}%";
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
            let mediaPlayer = pkgs.callPackage ./scripts/mediaplayer { };
            in {
              format = "{}    ${icon "" "#1DB954" 13}";
              max-length = 35;
              exec = "${mediaPlayer}/bin/mediaplayer.py 2> /dev/null";
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
            exec-if = "${playerctl} status";
            on-click = "${playerctl} --player=spotify next";
            tooltip = false;
          };

          "custom/spotify-prev" = {
            format = "{}";
            interval = 10;
            exec = "echo "; # ﭣ
            exec-if = "${playerctl} status";
            on-click = "${playerctl} --player=spotify previous";
            tooltip = false;
          };

          "sway/mode" = { format = "${icon "" "#1e2029" 11}   {}"; };
        };
      };
    };
  };
}
