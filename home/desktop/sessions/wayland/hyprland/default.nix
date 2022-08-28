{ inputs, config, lib, pkgs, ... }:

let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.modules.desktop.sessions.wayland.hyprland;
  hyprctl = "${pkgs.hyprland}/bin/hyprctl";
  handle_monitor_connect =
    pkgs.writeShellScriptBin "handle_monitor_connect.sh" ''
      function handle {
        if [ ''${1:0:12} = "monitoradded" ]; then
          ${hyprctl} dispatch moveworkspacetomonitor "1 1"
          ${hyprctl} dispatch moveworkspacetomonitor "2 2"
          ${hyprctl} dispatch moveworkspacetomonitor "3 1"
          ${hyprctl} dispatch moveworkspacetomonitor "4 2"
          ${hyprctl} dispatch moveworkspacetomonitor "5 1"
          ${hyprctl} dispatch moveworkspacetomonitor "6 2"
          ${hyprctl} dispatch moveworkspacetomonitor "7 1"
          ${hyprctl} dispatch moveworkspacetomonitor "8 2"
          ${hyprctl} dispatch moveworkspacetomonitor "9 1"
        fi
      }

      ${pkgs.socat}/bin/socat - UNIX-CONNECT:/tmp/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock | while read line; do handle $line; done
    '';
in {
  options.modules.desktop.sessions.wayland.hyprland.enable =
    mkEnableOption "Hyprland";

  imports = [ inputs.hyprland.homeManagerModules.default ];

  config = mkIf cfg.enable {
    home.packages = [ handle_monitor_connect ]
      ++ (with pkgs; [ swaybg swaylock swayidle ]);

    wayland.windowManager.hyprland = {
      enable = true;
      systemdIntegration = true;
      xwayland = true;
      # extraConfig = builtins.readFile ./hyprland.conf;
      extraConfig = ''
        $LAUNCHER = ${config.modules.desktop.apps.launchers.cmd}
        ${(builtins.readFile ./hyprland.conf)};
      '';
    };
  };
}
