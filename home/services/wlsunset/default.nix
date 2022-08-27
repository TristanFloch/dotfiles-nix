{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  wayland = config.modules.desktop.sessions.wayland;
  cfg = config.modules.services.wlsunset;
in {
  options.modules.services.wlsunset.enable = (mkEnableOption "wlsunset") // {
    default = wayland.enable;
  };

  config = mkIf cfg.enable {
    services.wlsunset = {
      enable = true;

      # Paris
      latitude = "48.9";
      longitude = "2.4";
    };
  };
}
