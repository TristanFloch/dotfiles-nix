{ config, lib, pkgs, ... }:

{
  imports = [
    ./dunst
    ./polybar
    ./rofi
    ./picom
  ];

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    slack
    xfce.thunar
    xarchiver
    evince
    thunderbird
    pavucontrol
    spotify
    discord
    pdfarranger
    gimp
    betterlockscreen
    teams
    viewnior
    inkscape
  ];
}
