{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf;
  cfg = config.modules.desktop.sessions.wayland;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ autotiling ];

    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures = {
        base = true;
        gtk = true;
      };
      config = let
        swaylock = "${pkgs.swaylock}/bin/swaylock";
        swaymsg = "${pkgs.sway}/bin/swaymsg";
        drun = "${pkgs.rofi}/bin/rofi -modi drun -show drun";
      in rec {
        modifier = "Mod4";
        bars = [ ]; # waybar is started by systemd
        fonts = {
          names = [ "Ubuntu" "Ubuntu Nerd Font" ];
          size = 11.0;
        };
        terminal = "${pkgs.alacritty}/bin/alacritty";
        defaultWorkspace = "workspace number 1";
        workspaceAutoBackAndForth = true;
        seat = { "*" = { xcursor_theme = "Dracula-cursors 16"; }; };
        input = { "*" = { tap = "enabled"; }; };
        output = let bg = "~/Pictures/IMG_1043.jpg fill";
        in {
          eDP-1 = {
            pos = "0 1080";
            res = "1920x1080@60Hz";
            inherit bg;
          };
          HDMI-A-1 = {
            pos = "0 0";
            res = "1920x1080@60Hz";
            inherit bg;
          };
        };

        workspaceOutputAssign = let
          primary = "HDMI-A-1";
          secondary = "eDP-1";
        in [
          { workspace = "1"; output = primary; }
          { workspace = "3"; output = primary; }
          { workspace = "5"; output = primary; }
          { workspace = "7"; output = primary; }
          { workspace = "9"; output = primary; }

          { workspace = "2"; output = secondary; }
          { workspace = "4"; output = secondary; }
          { workspace = "6"; output = secondary; }
          { workspace = "8"; output = secondary; }
          { workspace = "10"; output = secondary; }
        ];

        gaps = {
          inner = 14;
          outer = -2;
          smartGaps = false;
          smartBorders = "on";
        };

        colors = {
          focused = { border = "#6272A4"; background = "#6272A4"; text = "#F8F8F2"; indicator = "#6272A4"; childBorder = "#6272A4"; };
          focusedInactive = { border = "#44475A"; background = "#44475A"; text = "#F8F8F2"; indicator = "#44475A"; childBorder = "#44475A"; };
          unfocused = { border = "#282A36"; background = "#282A36"; text = "#BFBFBF"; indicator = "#282A36"; childBorder = "#282A36"; };
          urgent = { border = "#44475A"; background = "#FF5555"; text = "#F8F8F2"; indicator = "#FF5555"; childBorder = "#FF5555"; };
          placeholder = { border = "#282A36"; background = "#282A36"; text = "#F8F8F2"; indicator = "#282A36"; childBorder = "#282A36"; };
          background = "#F8F8F2";
        };

        modes = {
          resize = {
            l = "resize shrink width 5 px or 5 ppt";
            h = "resize grow width 5 px or 5 ppt";
            j = "resize shrink height 5 px or 5 ppt";
            k = "resize grow height 5 px or 5 ppt";

            Right = "resize shrink width 10 px or 10 ppt";
            Left = "resize grow width 10 px or 10 ppt";
            Down = "resize shrink height 10 px or 10 ppt";
            Up = "resize grow height 10 px or 10 ppt";

            Escape = "mode default";
            Return = "mode default";
            "${modifier}+r" = "mode default";
          };
        };

        startup = [
          {
            command = ''
            ${pkgs.swayidle}/bin/swayidle \
            timeout 300 ${swaylock} \
            timeout 600 '${swaymsg} "output * dpms off"' \
            resume '${swaymsg} "output * dpms on"'
          '';
          }
          {
            command = "${pkgs.autotiling}/bin/autotiling -w 1 2 3 4 5 6 7 8";
            always = true;
          }
        ];

        assigns = {
          "2" = [{ app_id = "firefox"; }];
          "5" = [{ class = "VirtualBox Machine"; }]; # FIXME
          "6" = [ { class = "discord"; } { class = "Slack"; } ];
          "7" = [{ app_id = "thunderbird"; }];
          "8" = [{ class = "Spotify"; }]; # FIXME
        };

        window = {
          border = 1;
          commands = [{
            command = "move to workspace $ws8";
            criteria = { class = "Spotify"; };
          }];
        };

        floating = {
          border = 1;
          criteria = [
            # { class = "VirtualBox Machine"; } # FIXME
          ];
        };

        keybindings = let
          mod = modifier;
          alt = "Mod1";
        in lib.mkOptionDefault {
          "${mod}+Shift+q" = "kill";
          "${mod}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
          "${mod}+d" = "exec ${drun}";
          "${mod}+Shift+e" = "exec ${pkgs.wlogout}/bin/wlogout --buttons-per-row 6 --column-spacing 40";

          "${mod}+n" = "border normal";

          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";

          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Up" = "focus up";
          "${mod}+Right" = "focus right";

          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";

          "${mod}+Shift+Left" = "move left";
          "${mod}+Shift+Down" = "move down";
          "${mod}+Shift+Up" = "move up";
          "${mod}+Shift+Right" = "move right";

          "${mod}+Control+Shift+h" = "move workspace to output left";
          "${mod}+Control+Shift+j" = "move workspace to output down";
          "${mod}+Control+Shift+k" = "move workspace to output up";
          "${mod}+Control+Shift+l" = "move workspace to output right";

          "${mod}+Control+Shift+Left" = "move workspace to output left";
          "${mod}+Control+Shift+Down" = "move workspace to output down";
          "${mod}+Control+Shift+Up" = "move workspace to output up";
          "${mod}+Control+Shift+Right" = "move workspace to output right";

          "${mod}+v" = "split h"; # TODO send notification
          "${mod}+g" = "split v"; # TODO send notification
          "${mod}+q" = "split toggle";

          "${mod}+Shift+space" = "floating toggle";
          "${mod}+Shift+t" = "floating toggle";

          "${mod}+Shift+1" = "move container to workspace $ws1; workspace $ws1";
          "${mod}+Shift+2" = "move container to workspace $ws2; workspace $ws2";
          "${mod}+Shift+3" = "move container to workspace $ws3; workspace $ws3";
          "${mod}+Shift+4" = "move container to workspace $ws4; workspace $ws4";
          "${mod}+Shift+5" = "move container to workspace $ws5; workspace $ws5";
          "${mod}+Shift+6" = "move container to workspace $ws6; workspace $ws6";
          "${mod}+Shift+7" = "move container to workspace $ws7; workspace $ws7";
          "${mod}+Shift+8" = "move container to workspace $ws8; workspace $ws8";
          "${mod}+Shift+9" = "move container to workspace $ws9; workspace $ws9";

          "XF86MonBrightnessUp" = "exec brightnessctl -c backlight set +10%";
          "XF86MonBrightnessDown" = "exec brightnessctl -c backlight set 10%-";
          "XF86AudioRaiseVolume" = "exec amixer set Master 5%+";
          "XF86AudioLowerVolume" = "exec amixer set Master 5%-";
          "XF86AudioMute" = "exec amixer set Master toggle";

          "${mod}+F1" = "exec emacs";
          "${mod}+F2" = "exec firefox";
          "${mod}+F3" = "exec thunar";
          "${mod}+F4" = "exec pavucontrol";
        };
      };
      extraConfig = ''
        set $ws1 1
        set $ws2 2
        set $ws3 3
        set $ws4 4
        set $ws5 5
        set $ws6 6
        set $ws7 7
        set $ws8 8
        set $ws9 9
      '';

      extraSessionCommands = ''
        export SDL_VIDEODRIVER=wayland
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
        export _JAVA_AWT_WM_NONREPARENTING=1
        export MOZ_ENABLE_WAYLAND=1
      '';
    };
  };
}
