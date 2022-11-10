{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  wayland = config.modules.desktop.sessions.wayland;
  cfg = config.modules.desktop.apps.mako;
  colors = config.modules.theme.colors;
in {
  options.modules.desktop.apps.mako.enable = (mkEnableOption "mako") // {
    default = wayland.enable;
  };

  config = mkIf cfg.enable {
    programs.mako = {
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
      backgroundColor = "${colors.background-dark}dd";
      textColor = "${colors.foreground}ff";
      borderColor = "${colors.background-dark}dd";
      extraConfig = ''
        [urgency=low]
        border-color=${colors.background-dark}dd

        [urgency=normal]
        border-color=${colors.background-dark}dd

        [urgency=high]
        border-color=${colors.orange}ff
      '';
    };
  };
}
