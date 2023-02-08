{ inputs, config, lib, pkgs, ... }:

let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.modules.desktop.apps.bars.eww;
  wayland = config.modules.desktop.sessions.wayland;
  colors = config.modules.theme.colors;
in {
  options.modules.desktop.apps.bars.eww.enable = mkEnableOption "eww";

  config = mkIf cfg.enable {
    modules.desktop.apps.bars.cmd =
      "${config.programs.eww.package}/bin/eww open bar";

    home.packages = let eww-ws = inputs.eww-ws.packages.${pkgs.system}.default;
    in [ eww-ws pkgs.mediaplayer-monitor pkgs.pulseaudio ];

    programs.eww = {
      enable = true;
      package = if wayland.enable then pkgs.eww-wayland else pkgs.eww;
      configDir = ./bar;
    };
  };
}
