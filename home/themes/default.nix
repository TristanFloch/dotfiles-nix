{ config, lib, pkgs, ... }:

let
  inherit (lib) mkOption types;
  # TODO assert theme is available
  available = rec {
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
    };
    catppuccin-mocha.colors = {
      background-dark = "#1D1D2D";
      background = "#1D1D2D";
      foreground = "#CDD6F4";
      comment = "#B4BEFE";
      cyan = "#88B3F9";
      green = "#A6E3A1";
      orange = "#FAB387";
      pink = "#F5C2E7";
      purple = "#CBA6F7";
      red = "#F38BA8";
      yellow = "#F9E2AF";
    };
    catppuccin.colors = catppuccin-mocha.colors; # default
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
    modules.theme.colors = let
      variant = config.modules.theme.variant;
      avail-str = config.modules.theme.name
        + lib.optionalString (variant != null) ("-" + variant);
    in available.${avail-str}.colors;
  };
}
