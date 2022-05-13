{ options, config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.desktop.sessions.x;
in
{
  options.modules.desktop.sessions.x.enable = mkEnableOption "X session";

  imports = [
    ./wms
  ];

  config = mkIf cfg.enable {
    xsession.enable = true;

    # TODO move to themes
    xsession.pointerCursor = {
      package = pkgs.xorg.xcursorthemes;
      name = "Dracula-cursors";
      size = 16;
    };

    xresources.properties = { "Xft.dpi" = "96"; };
  };
}
