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
    ./wlogout
  ];

  home.packages = with pkgs; [
    slack
    xfce.thunar
    xarchiver
    evince
    (if xsession.enable then thunderbird else thunderbird-wayland)
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
