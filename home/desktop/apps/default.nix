{ config, lib, pkgs, ... }:

let xsession = config.modules.desktop.sessions.x;
in {
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
    ./mako
  ];

  home.packages = with pkgs;
    [
      slack
      xfce.thunar
      xarchiver
      evince
      (if xsession.enable then thunderbird else thunderbird-wayland)
      pavucontrol
      spotify
      pdfarranger
      gimp
      teams
      viewnior
      inkscape
      brightnessctl
      gnupg
      bitwarden
      bitwarden-cli
      cachix
      discord
    ] ++ (if xsession.enable then [ feh betterlockscreen ] else [ ]);
}
