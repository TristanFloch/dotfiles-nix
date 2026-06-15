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
        ".bak"
        ".default"
        ".dev"
        ".example"
      ];
      italic-text = "always";
      map-syntax = [
        ".ino:C++"
      ];
      theme = "auto:system";
      theme-dark = "OneHalfDark";
      theme-light = "OneHalfLight";
    };
  };
}
