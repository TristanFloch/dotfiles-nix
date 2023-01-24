{ config, lib, pkgs, ... }:

let
  inherit (lib) types mkOption;
  wayland = config.modules.desktop.sessions.wayland;
  colors = config.modules.theme.colors;
in {
  options.modules.desktop.apps.logout.cmd = mkOption {
    type = types.str;
    default = "${pkgs.wlogout}/bin/wlogout --buttons-per-row 5 --column-spacing 40";
    description = "Logout menu command line";
  };

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
            background-color: ${colors.background};
            background-repeat: no-repeat;
            background-position: center;
            background-size: 25%;
            min-width: 50px;
            margin-top: 140px;
            margin-bottom: 140px;
            border-radius: 8px;
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
      '';
      configFile."wlogout/icons" = {
        source = ./icons;
        recursive = true;
      };
    };
  };
}
