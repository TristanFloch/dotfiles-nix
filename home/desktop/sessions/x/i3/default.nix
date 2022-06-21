{ options, config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  xsession = config.modules.desktop.sessions.x;
  cfg = xsession.i3;
in
{
  options.modules.desktop.sessions.x.i3.enable =
    (mkEnableOption "i3 gaps")
    // { default = xsession.enable; };

  config = mkIf cfg.enable {
    xsession.windowManager.i3 = rec {
      enable = true;
      package = pkgs.i3-gaps;
      config = {
        modifier = "Mod4";
        bars = [ ];
        terminal = "${pkgs.alacritty}/bin/alacritty";
        defaultWorkspace = "workspace number 1";
        workspaceAutoBackAndForth = true;

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
          };
        };

        startup = [
          { command = "systemctl --user restart polybar"; always = false; notification = false; }
          { command = "feh --bg-fill ~/Pictures/IMG_1043.jpg"; always = false; notification = false; }
        ];

        assigns = {
          "2" = [{ class = "Firefox"; }];
          "5" = [{ class = "VirtualBox Machine"; }]; # FIXME
          "6" = [{ class = "discord"; } { class = "Slack"; }];
          "7" = [{ class = "Thunderbird"; }];
          # "8" = [{ class = "Spotify"; }]; # FIXME
        };

        window = {
          border = 1;
          commands = [{ command = "move to workspace $ws8"; criteria = { class = "Spotify"; }; }];
        };

        floating = {
          border = 1;
          criteria = [
            # { class = "VirtualBox Machine"; } # FIXME
          ];
        };

        keybindings =
          let
            mod = config.modifier;
          in
          lib.mkOptionDefault {
            "${mod}+Shift+q" = "kill";
            "${mod}+d" = "exec rofi -show drun";
            "${mod}+Shift+e" = "exec ~/.config/rofi/powermenu.sh";

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
    };
  };
}
