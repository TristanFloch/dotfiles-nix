{ config, lib, pkgs, ... }:

let
  xsession = config.modules.desktop.sessions.x;
in
{
  imports = [
    ./dunst
    ./polybar
    ./waybar
    ./rofi
    ./wofi
    ./swaylock
    ./picom
    ./mailspring
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
    brightnessctl
    gnupg
  ] ++ (if xsession.enable then [ feh ] else [ ]);
}
