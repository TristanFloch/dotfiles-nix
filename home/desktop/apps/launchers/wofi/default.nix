{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  wayland = config.modules.desktop.sessions.wayland;
  cfg = config.modules.desktop.apps.launchers.wofi;
  colors = config.modules.theme.colors;
in {
  options.modules.desktop.apps.launchers.wofi.enable =
    (mkEnableOption "Wofi launcher") // {
      default = wayland.enable;
    };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ wofi ];

    modules.desktop.apps.launchers.cmd = "${pkgs.wofi}/bin/wofi";

    xdg.configFile."wofi/config".source = ./config;
    xdg.configFile."wofi/style.css".text = ''
      window {
          margin: 0px;
          border-radius: 8px;
          background-color: ${colors.background-dark};
          box-shadow: rgba(0, 0, 0, 0.45) 0px 5px 15px;
      }

      #input {
          margin: 5px;
          border: none;
          color: ${colors.foreground};
          background-color: ${colors.background};
          border-radius: 8px;
          border: solid 1px ${colors.purple};
          padding: 4px;
          padding-left: 10px;
      }

      #inner-box {
          margin: 5px;
          border: none;
          background-color: ${colors.background-dark};
          border-radius: 8px;
      }

      #outer-box {
          margin: 1px;
          border: none;
          background-color: ${colors.background-dark};
          border-radius: 8px;
      }

      #scroll {
          border-radius: 8px;
      }

      #text {
          margin-left: 7px;
          border: none;
          color: ${colors.foreground};
      }

      #entry {
          padding: 10px;
          border-radius: 8px;
      }

      #entry:selected,
      #img:selected,
      #text:selected {
          background-color: ${colors.background};
      }
    '';
  };
}
