{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf mkEnableOption;
  wayland = config.modules.desktop.sessions.wayland;
  cfg = wayland.sway;
in {
  options.modules.desktop.sessions.wayland.sway.enable =
    (mkEnableOption "Sway")
    // { default = wayland.enable; };

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
        grim = "${pkgs.grim}/bin/grim";
        jq = "${pkgs.jq}/bin/jq";
        slurp = "${pkgs.slurp}/bin/slurp";
        wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";
        brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
        amixer = "${pkgs.alsa-utils}/bin/amixer";
        playerctl = "${pkgs.playerctl}/bin/playerctl";
        drun = config.modules.desktop.apps.launchers.cmd;
        logout = config.modules.desktop.apps.logout.cmd;
        bar = config.modules.desktop.apps.bars.cmd;
      in rec {
        modifier = "Mod4";
        bars = [ ];
        fonts = {
          names = [ "Ubuntu" "Ubuntu Nerd Font" ];
          size = 11.0;
        };
        terminal = "${pkgs.alacritty}/bin/alacritty";
        defaultWorkspace = "workspace number 1";
        workspaceAutoBackAndForth = true;
        seat = { "*" = { xcursor_theme = "Dracula-cursors 16"; }; };
        input = { "*" = {
          tap = "enabled";
          xkb_layout = "us";
          xkb_variant = "altgr-intl";
        }; };
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

        colors = let
          colors = config.modules.theme.colors;
        in {
          focused = { border = colors.cyan; background = colors.cyan; text = colors.foreground; indicator = colors.cyan; childBorder = colors.cyan; };
          focusedInactive = { border = colors.background-dark; background = colors.background-dark; text = colors.foreground; indicator = colors.background-dark; childBorder = colors.background-dark; };
          unfocused = { border = colors.background; background = colors.background; text = colors.foreground; indicator = colors.background; childBorder = colors.background; };
          urgent = { border = colors.background-dark; background = colors.red; text = colors.foreground; indicator = colors.red; childBorder = colors.red; };
          placeholder = { border = colors.background; background = colors.background; text = colors.foreground; indicator = colors.background; childBorder = colors.background; };
          background = colors.foreground;
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
          }
        ] ++ (if !(bar == "") then [
          { command = bar; }
        ] else [ ]);

        assigns = {
          "2" = [{ app_id = "firefox"; }];
          "5" = [{ class = "VirtualBox Machine"; }]; # FIXME
          "6" = [
            { class = "discord"; }
            { class = "WebCord"; }
            { class = "Slack"; }
          ];
          "7" = [{ app_id = "thunderbird"; }];
          "8" = [{ class = "Spotify"; }]; # FIXME
        };

        window = {
          border = 1;
          commands = [
            {
              command = "move to workspace $ws8";
              criteria = { class = "Spotify"; };
            }
          ];
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
          "${mod}+Shift+r" = "reload";
          "${mod}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
          "${mod}+d" = "exec ${drun}";
          "${mod}+Shift+e" = "exec ${logout}";

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

          "XF86MonBrightnessUp" = "exec ${brightnessctl} -c backlight set +10%";
          "XF86MonBrightnessDown" = "exec ${brightnessctl} -c backlight set 10%-";
          "XF86AudioRaiseVolume" = "exec ${amixer} set Master 5%+";
          "XF86AudioLowerVolume" = "exec ${amixer} set Master 5%-";
          "XF86AudioMute" = "exec ${amixer} set Master toggle";
          "XF86AudioNext" = "exec ${playerctl} --player=spotify next";
          "XF86AudioPrev" = "exec ${playerctl} --player=spotify previous";
          "XF86AudioPause" = "exec ${playerctl} --player=spotify pause";
          "XF86AudioPlay" = "exec ${playerctl} --player=spotify play";

          "${mod}+F1" = "exec emacs";
          "${mod}+F2" = "exec firefox";
          "${mod}+F3" = "exec thunar";
          "${mod}+F4" = "exec pavucontrol";

          "Print" = "exec ${grim} -g \"$(${swaymsg} -t get_tree | ${jq} -j '.. | select(.type?) | select(.focused).rect | \"\(.x),\(.y) \(.width)x\(.height)\"')\""; # FIXME
          "${mod}+Shift+s" = "exec ${grim} -g \"$(${slurp})\" - | ${wl-copy}";
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
