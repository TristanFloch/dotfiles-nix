{ options, config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.desktop.sessions.x;
in
{
  options.modules.desktop.sessions.x.enable = mkEnableOption "X session";

  imports = [ ./i3 ./xmonad ];

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;

      displayManager = {
        # defaultsession is set in ./i3 or ./xmonad
        lightdm.enable = true;
        autoLogin.enable = true;
        autoLogin.user = "tristan";
      };

      libinput.enable = true;
      layout = "us, us_intl";
    };
  };
}
