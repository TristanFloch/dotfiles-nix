{ config, lib, pkgs, ... }:

let
  wayland = config.modules.desktop.sessions.wayland;
  available-themes = {
    dracula.colors = {
      background-dark = "#1e2029";
      background = "#282a36";
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
  };
  colors = available-themes.${config.home.theme.name}.colors;
in {
  config = lib.mkIf wayland.enable {
    home.packages = with pkgs; [ wlogout ];

    xdg = {
      configFile."wlogout/layout".source = ./layout;
      configFile."wlogout/style.css".text = ''
        * {
            background-image: none;
        }
        window {
            /* background-color: rgba(12, 12, 12, 0.3); */
            background-color: ${colors.background-dark};
        }

        button {
            color: ${colors.foreground};
            background-color: ${colors.foreground};
            border-style: solid;
            border-width: 1px;
            border-color: ${colors.comment};
            background-repeat: no-repeat;
            background-position: center;
            background-size: 25%;
            min-width: 60px;
            margin-top: 140px;
            margin-bottom: 140px;
            border-radius: 25px;
        }

        button:focus, button:active, button:hover {
            background-color: ${colors.purple};
            border-color: ${colors.purple};
            color: ${colors.background};
            outline-style: none;
        }

        #lock {
            background-image: image(url("./icons/lock.png"));
        }

        #shutdown {
            background-image: image(url("./icons/shutdown.png"));
        }

        #reboot {
            background-image: image(url("./icons/reboot.png"));
        }

        #suspend {
            background-image: image(url("./icons/suspend.png"));
        }

        #logout {
            background-image: image(url("./icons/logout.png"));
        }

        #hibernate {
            background-image: image(url("./icons/hibernate.png"));
        }
      '';
      configFile."wlogout/icons" = {
        source = ./icons;
        recursive = true;
      };
    };
  };
}
