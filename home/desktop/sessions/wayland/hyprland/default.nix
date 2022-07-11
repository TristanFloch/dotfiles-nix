{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.modules.desktop.sessions.wayland.hyprland;
  hyprctl = "${pkgs.hyprland}/bin/hyprctl";
  handle_monitor_connect = pkgs.writeShellScriptBin "handle_monitor_connect.sh" ''
    function handle {
      if [ ''${1:0:12} = "monitoradded" ]; then
        ${hyprctl} dispatch moveworkspacetomonitor "1 2"
        ${hyprctl} dispatch moveworkspacetomonitor "3 2"
        ${hyprctl} dispatch moveworkspacetomonitor "5 2"
        ${hyprctl} dispatch moveworkspacetomonitor "7 2"
        ${hyprctl} dispatch moveworkspacetomonitor "9 2"
      fi
    }

    ${pkgs.socat}/bin/socat - UNIX-CONNECT:/tmp/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock | while read line; do handle $line; done
  '';
in {
  options.modules.desktop.sessions.wayland.hyprland.enable =
    mkEnableOption "Hyprland";

  config = mkIf cfg.enable {
    home.packages = [ handle_monitor_connect ];

    xdg.configFile = {
      "hypr/hyprland.conf" = {
        source = ./hyprland.conf;
        onChange = "${hyprctl} reload";
      };
    };

    systemd.user.targets.hyprland-session = {
      Unit = {
        Description = "hyprland compositor session";
        Documentation = [ "man:systemd.special(7)" ];
        BindsTo = [ "graphical-session.target" ];
        Wants = [ "graphical-session-pre.target" ];
        After = [ "graphical-session-pre.target" ];
      };
    };

    systemd.user.targets.tray = {
      Unit = {
        Description = "Home Manager System Tray";
        Requires = [ "graphical-session-pre.target" ];
      };
    };
  };
}
