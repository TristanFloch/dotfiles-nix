{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf;
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
            "sway/mode"
            "keyboard-state"
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
            swaymsg = "${pkgs.sway}/bin/swaymsg";
            sway-scratch = pkgs.writeShellScriptBin "sway-scratch.sh" ''
              count=$(${swaymsg} -r -t get_tree |
                      ${pkgs.jq}/bin/jq -r 'recurse(.nodes[]) |
                      first(select(.name=="__i3_scratch")) |
                      .floating_nodes | length')

              if [[ "$count" -eq 0 ]]; then
                class="none"
              elif [[ "$count" -eq 1 ]]; then
                class="one"
              elif [[ "$count" -gt 1 ]]; then
                class="many"
              else
                class="unknown"
              fi

              printf '{"text":"%s", "class":"%s", "alt":"%s", "tooltip":"%s"}\n' "$count" "$class" "$class" "$count"
            '';
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
            exec = "${sway-scratch}/bin/sway-scratch.sh";
            exec-if = "exit 0";
            on-click = "${swaymsg} scratchpad show";
            on-click-right = "${swaymsg} move window to scratchpad";
            tooltip = true;
          };
        };
      };
    };
  };
}
