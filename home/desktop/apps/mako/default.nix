{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  wayland = config.modules.desktop.sessions.wayland;
  cfg = config.modules.desktop.apps.mako;
in {
  options.modules.desktop.apps.mako.enable = (mkEnableOption "mako") // {
    default = wayland.enable;
  };

  config = mkIf cfg.enable {
    programs.mako = let
      colors = {
        background = "#1e2029";
        text = "#f8f8f2";
        urgent = "#f1fa8c";
      };
    in {
      enable = true;
      anchor = "top-right";
      borderRadius = 6;
      defaultTimeout = 5000;
      font = "Ubuntu 11";
      icons = true;
      iconPath = "${config.gtk.iconTheme.package}/share/icons/Dracula";
      format = ''
        <b>%s</b>\n%b
      '';
      padding = "10,10,10,10";
      margin = "10,20,10,20";

      # Dracula theme
      backgroundColor = "${colors.background}dd";
      textColor = "${colors.text}ff";
      borderColor = "${colors.background}dd";
      extraConfig = ''
        [urgency=low]
        border-color=${colors.background}dd

        [urgency=normal]
        border-color=${colors.background}dd

        [urgency=high]
        border-color=${colors.urgent}ff
      '';
    };
  };
}
