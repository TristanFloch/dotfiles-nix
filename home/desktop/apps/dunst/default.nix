{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  xsession = config.modules.desktop.sessions.x;
  cfg = config.modules.desktop.apps.dunst;
in {
  options.modules.desktop.apps.dunst.enable = (mkEnableOption "dunst") // {
    default = xsession.enable;
  };

  config = mkIf cfg.enable {
    services.dunst = {
      enable = true;
      configFile = ./dunstrc;
    };
  };
}
