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
    services.xserver = {
      desktopManager = {
        xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
          thunarPlugins = with pkgs.xfce; [ thunar-archive-plugin ];
        };
      };

      displayManager.defaultSession = "xfce+i3";

      windowManager.i3.enable = true;
    };
  };
}
