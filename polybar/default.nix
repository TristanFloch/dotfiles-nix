{ config, lib, pkgs, ... }:

{
  services.polybar =
    let
      colors = {
        background = "#1e2029";
        foreground = "#f8f8f2";
        transparent = "#00000000";
        comment = "#6272a4";
        cyan = "#8be9fd";
        green = "#50fa7b";
        orange = "#ffb86c";
        pink = "#ff79c6";
        purple = "#bd93f9";
        red = "#ff5555";
        yellow = "#f1fa8c";
        black = "#000000";
      };
      fonts = [
        "Ubuntu Nerd Font:size=10.5:style=Book;2"
        "Ubuntu Nerd Font Mono:style=Regular:size=13;3"
        "NotoSans Nerd Font:style=ExtraCondensed:size=20;5"
      ];
    in
    {
      enable = true;
      package = pkgs.polybarFull;
      script = ''
        for m in $(polybar --list-monitors | ${pkgs.coreutils}/bin/cut -d":" -f1); do
          MONITOR=$m polybar main &
        done
      '';
      settings = {
        "global/wm" = {
          margin-top = 0;
          margin-bottom = 0;
        };

        "bar/main" = {
          enable-ipc = true;
          monitor = "\${env:MONITOR}";
          witdh = "100%";
          height = 36;
          radius = 0;
          fixed-center = true;
          bottom = true;
          background = colors.transparent;
          foreground = colors.foreground;
          border-top-size = 0;
          border-bottom-size = 6;
          border-bottom-color = colors.transparent;
          border-left-size = 0;
          border-left-color = colors.transparent;
          border-right-size = 0;
          border-right-color = colors.transparent;
          padding-left = 0;
          padding-right = 0;
          module-margin-left = 0;
          module-margin-right = 0;
          modules-left = "xwindow right left date right left my-xkeyboard right left-spotify spotify right-spotify";
          modules-center = "left i3 right";
          modules-right = "left backlight right left pulseaudio right left memory right left cpu right left filesystem right left temperature right left battery right left";
          font = fonts;
          cursor-click = "pointer";
          cursor-scroll = "ns-resize";
          tray-detached = false;
          tray-position = "right";
          tray-scale = 1;
          tray-background = colors.background;
        };

        "settings" = {
          compositing-background = "source";
          compositing-foreground = "over";
          compositing-overline = "over";
          compositing-underline = "over";
          compositing-border = "over";
          format-foreground = colors.foreground;
          format-background = colors.background;
          pseudo-transparency = false;
        };

        "module/left" = {
          type = "custom/text";
          content-background = colors.transparent;
          content-foreground = colors.background;
          content = "";
          content-font = 3;
        };

        "module/right" = {
          type = "custom/text";
          "inherit" = "module/left";
          content = "";
        };

        "module/xwindow" = {
          type = "internal/xwindow";

          format = "<label>";
          # format-prefix = " ";
          # format-prefix = " ";
          format-prefix = " ";
          format-prefix-foreground = colors.purple;
          format-prefix-font = 2;

          label = "   %title%";
          label-maxlen = 30;
        };

        "module/filesystem" = {
          type = "internal/fs";
          interval = 120;

          mount-0 = "/";

          format-mounted-prefix = "";
          format-mounted-prefix-foreground = colors.purple;
          format-mounted-prefix-font = 2;
          format-mounted = "<label-mounted>";

          format-unmounted-prefix = "";
          format-unmounted-prefix-font = 2;
          format-unmounted = "<label-unmounted>";
          format-unmounted-foreground = colors.comment;

          label-mounted = "   %free%";
          label-unmounted = "   %mountpoint% not mounted";
        };

        "module/i3" = rec {
          type = "internal/i3";
          format = "<label-state> <label-mode>";
          index-sort = true;
          wrapping-scroll = false;

          # Only show workspaces on the same output as the bar;
          pin-workspaces = true;

          # useless here;
          # label-mode-padding = 2;
          # label-mode-foreground = #000;
          # label-mode-background = colors.primary;

          # focused = Active workspace on focused monitor;
          label-focused = "%icon%";
          label-focused-padding = 3;
          label-focused-foreground = colors.purple;
          label-focused-font = 2;

          # unfocused = Inactive workspace on any monitor;
          label-unfocused = "%icon%";
          label-unfocused-padding = label-focused-padding;
          label-unfocused-foreground = colors.foreground;
          label-unfocused-font = label-focused-font;

          # visible = Active workspace on unfocused monitor;
          label-visible = "%icon%";
          label-visible-padding = label-focused-padding;
          label-visible-foreground = colors.comment;
          label-visible-font = label-focused-font;

          # urgent = Workspace with urgency hint set;
          label-urgent = "%icon%";
          label-urgent-padding = label-focused-padding;
          label-urgent-foreground = colors.orange;
          label-urgent-font = label-focused-font;

          # Separator in between workspaces;
          # label-separator = |;
          #   ;
          # ;
          ws-icon-0 = "1;";
          ws-icon-1 = "2;";
          ws-icon-2 = "3;";
          ws-icon-3 = "4;漣";
          ws-icon-4 = "5;";
          ws-icon-5 = "6;";
          ws-icon-6 = "7;";
          ws-icon-7 = "8;";
          ws-icon-8 = "9";
          ws-icon-9 = "10";
          ws-icon-default = "";
        };

        "module/backlight" = {
          type = "internal/backlight";

          # Use the following command to list available cards:;
          # $ ls -1 /sys/class/backlight/;
          card = "amdgpu_bl0";

          # Enable changing the backlight with the scroll wheel;
          # NOTE: This may require additional configuration on some systems. Polybar will;
          # write to `/sys/class/backlight/${self.card}/brightness` which requires polybar;
          # to have write access to that file.;
          # DO NOT RUN POLYBAR AS ROOT.;
          # The recommended way is to add the user to the;
          # `video` group and give that group write-privileges for the `brightness` file.;
          # See the ArchWiki for more information:;
          # https://wiki.archlinux.org/index.php/Backlight#ACPI;
          # Default: false;
          enable-scroll = true; # FIXME does not work on NixOS;

          # Available tags:;
          # <label> (default);
          # <ramp>;
          # <bar>;
          # format = <ramp> <label> <bar>;
          format = "<ramp> <label>";

          # Available tokens:;
          # %percentage% (default);
          label = "  %percentage%%";
          label-font = 1;

          ramp-0 = "";
          ramp-0-foreground = colors.comment;
          ramp-1 = "";
          ramp-1-foreground = colors.purple;
          ramp-2 = "";
          ramp-2-foreground = colors.cyan;
          ramp-font = 2;
        };

        "module/cpu" = {
          # type = internal/cpu;
          # interval = 2;
          # label = %percentage:2%%;
          type = "internal/cpu";
          # Seconds to sleep between updates;
          # Default: 1;
          interval = 1;

          # format-prefix = "";
          format-prefix = "";
          format-prefix-font = 2;
          format-prefix-foreground = colors.cyan;

          # Available tags:;
          # <label> (default);
          # <bar-load>;
          # <ramp-load>;
          # <ramp-coreload>;
          format = "<label>";


          # Available tokens:;
          # %percentage% (default) - total cpu load;
          # %percentage-cores% - load percentage for each core;
          # %percentage-core[1-9]% - load percentage for specific core;
          label = "   %percentage%%";
        };

        "module/memory" = {
          # type = internal/memory;
          # interval = 2;
          # label = %percentage_used%%;
          type = "internal/memory";
          interval = 1;
          # Available tokens:;
          # %percentage_used% (default);
          # %percentage_free%;
          # %gb_used%;
          # %gb_free%;
          # %gb_total%;
          # %mb_used%;
          # %mb_free%;
          # %mb_total%;
          label = "   %gb_used%";

          format = "<label>";
          format-prefix = "力";
          format-prefix-font = 2;
          format-prefix-foreground = colors.pink;
        };


        "module/date" = {
          type = "internal/date";
          interval = 5;

          date = "%d/%m";
          date-alt = "%a. %d/%m/%Y";

          time = "%H:%M";
          time-alt = "%H:%M:%S";

          format-prefix = "";
          format-prefix-font = 2;
          format-prefix-foreground = colors.comment;

          label = "   %date% - %time%";
        };

        "module/pulseaudio" = {
          type = "internal/pulseaudio";

          # Sink to be used, if it exists (find using `pacmd list-sinks`, name field);
          # If not, uses default sink;
          # sink = alsa_output.pci-0000_12_00.3.analog-stereo;

          # Use PA_VOLUME_UI_MAX (~153%) if true, or PA_VOLUME_NORM (100%) if false;
          # Default: true;
          use-ui-max = true;

          # Interval for volume increase/decrease (in percent points);
          # Default: 5;
          interval = 5;

          # Available tags:;
          # <label-volume> (default);
          # <ramp-volume>;
          # <bar-volume>;
          format-volume = "<ramp-volume> <label-volume>";

          # Available tags:;
          # <label-muted> (default);
          # <ramp-volume>;
          # <bar-volume>;
          format-muted-prefix = "";
          format-muted-prefix-font = 2;
          format-muted-foreground = colors.comment;
          format-muted = "<label-muted>";

          # Available tokens:;
          # %percentage% (default);
          # %decibels%;
          label-volume = "  %percentage%%";
          label-volume-font = 1;

          # Available tokens:;
          # %percentage% (default);
          # %decibels%;
          # label-muted = "🔇 ";
          label-muted = "  %percentage%%";

          # Only applies if <ramp-volume> is used;
          # ramp-volume-0 = "🔈 ";
          # ramp-volume-1 = "🔉 ";
          # ramp-volume-2 = "🔊 ";

          ramp-volume-0 = "";
          ramp-volume-0-foreground = colors.green;
          ramp-volume-1 = "";
          ramp-volume-1-foreground = colors.green;
          ramp-volume-2 = "";
          ramp-volume-2-foreground = colors.yellow;
          ramp-volume-3 = "";
          ramp-volume-3-foreground = colors.orange;
          ramp-volume-4 = "";
          ramp-volume-4-foreground = colors.red;
          ramp-volume-font = 2;

          # Right and Middle click;
          click-right = "pavucontrol";
        };

        "module/battery" = {
          type = "internal/battery";
          # ls -1 /sys/class/power_supply/;
          battery = "BATT";
          adapter = "ACAD";

          full-at = 80;

          format-charging = "<animation-charging> <label-charging>";
          label-charging = "  %percentage%%";
          label-charging-font = 1;

          format-discharging = "<ramp-capacity> <label-discharging>";
          label-discharging = "  %percentage%%";
          label-discharging-font = 1;

          format-full-prefix = "";
          format-full-prefix-font = 2;
          format-full-prefix-foreground = colors.green;
          format-full = "<label-full>";
          label-full = "  %percentage%%";
          label-full-font = 1;

          ramp-capacity-0 = "";
          ramp-capacity-0-foreground = colors.red;
          ramp-capacity-1 = "";
          ramp-capacity-1-foreground = colors.orange;
          ramp-capacity-2 = "";
          ramp-capacity-2-foreground = colors.orange;
          ramp-capacity-3 = "";
          ramp-capacity-3-foreground = colors.yellow;
          ramp-capacity-4 = "";
          ramp-capacity-4-foreground = colors.green;
          ramp-capacity-font = 2;

          animation-charging-0 = "";
          animation-charging-1 = "";
          animation-charging-2 = "";
          animation-charging-3 = "";
          animation-charging-4 = "";
          animation-charging-framerate = 750;
          animation-charging-font = 2;
          animation-charging-foreground = colors.yellow;
        };

        "module/temperature" = {
          type = "internal/temperature";
          thermal-zone = 0;
          warn-temperature = 65;

          format-prefix = "";
          format-prefix-font = 2;
          format-prefix-foreground = colors.red;

          format = "<label>";
          format-warn-prefix = "";
          format-warn-prefix-font = 2;
          format-warn-prefix-foreground = colors.red;
          format-warn = "<label-warn>";

          label = "   %temperature-c%";
          label-warn = "   %temperature-c%";
          label-warn-foreground = colors.red;
        };

        "module/spotify" = {
          type = "custom/script";

          interval = 1;
          exec-if = "pgrep spotify";

          format-prefix = "";
          format-prefix-font = 2;
          format-prefix-foreground = "#1db954";

          format = "<label>";

          label = "   %output:0:30:...%";

          exec = "python3 ~/.config/polybar/scripts/polybar_status.py";

          scroll-up = "playerctl --player=spotify previous";
          scroll-down = "playerctl --player=spotify next";
          click-left = "playerctl --player=spotify play-pause";
          click-right = "i3-msg [class=Spotify] focus";
        };

        "module/left-spotify" = {
          type = "custom/script";

          interval = 5;
          exec-if = "pgrep spotify";
          exec = "echo ";

          format = "<label>";
          format-font = 3;

          label = "%output%";
          label-background = colors.transparent;
          label-foreground = colors.background;
        };

        "module/right-spotify" = {
          "inherit" = "module/left-spotify";
          exec = "echo ";
        };

        "module/my-xkeyboard" = {
          type = "custom/ipc";

          format = "<output>";
          format-foreground = colors.orange;
          format-font = 2;

          hook-0 = "echo ";
          hook-1 = "~/.config/polybar/scripts/switch_layout.sh";

          click-left = "polybar-msg -p %pid% hook my-xkeyboard 2";

          initial = 1;
        };
      };
    };

  home.packages = with pkgs; [
    playerctl
  ];

  home.file = {
    # ".config/polybar/colors.ini".source = ./colors.ini;
    # ".config/polybar/modules.ini".source = ./modules.ini;
    # ".config/polybar/fonts.ini".source = ./fonts.ini;
    ".config/polybar/scripts" = {
      source = ./scripts;
      recursive = true;
    };
  };
}
