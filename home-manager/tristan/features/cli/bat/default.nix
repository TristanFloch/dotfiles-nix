{ config, pkgs, ... }:
{
  programs.bat = {
    enable = true;
    package = pkgs.unstable.bat;
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      batgrep
      batwatch
      prettybat
    ];
    config = {
      ignored-suffix = [
        ".backup"
        ".back"
        ".default"
        ".dev"
      ];
      italic-text = "always";
      map-syntax = [
        ".ino:C++"
      ];
      # FIXME https://github.com/sharkdp/bat/issues/3269
      # theme-light = "OneHalfLight";
      # theme-dark = "OneHalfDark";
    };
  };
}
