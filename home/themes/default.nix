{ config, lib, pkgs, ... }:

let
  inherit (lib) mkOption types;
  # TODO assert theme is available
  available = {
    dracula.colors = {
      background-dark = "#1e2029";
      background = "#282a36";
      foreground = "#f8f8f2";
      comment = "#6272a4";
      cyan = "#8be9fd";
      green = "#50fa7b";
      orange = "#ffb86c";
      pink = "#ff79c6";
      purple = "#bd93f9";
      red = "#ff5555";
      yellow = "#f1fa8c";
      black = "#000000";
    };
  };
in {
  imports = [ ./gtk ./font ./qt ./cursor ];

  options.modules.theme.name = mkOption {
    description = "theme to use cross-config";
    type = types.uniq types.str;
    default = "dracula";
  };
  options.modules.theme.variant = lib.mkOption {
    type = types.nullOr types.str;
    default = null;
  };
  options.modules.theme.colors = mkOption {
    type = with types; attrsOf str;
    default = null;
  };

  config = {
    modules.theme.colors = available.${config.modules.theme.name}.colors;
  };
}
