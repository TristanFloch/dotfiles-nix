{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ discord discocss ];

  xdg.configFile."discocss/custom.css".source = ./dracula.css;
}
