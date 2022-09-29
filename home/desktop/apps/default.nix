{ inputs, config, lib, pkgs, ... }:

let
  xsession = config.modules.desktop.sessions.x;
  webcord = inputs.webcord.packages.${pkgs.system}.default;
  myThunar = pkgs.xfce.thunar.override {
    thunarPlugins = with pkgs.xfce; [
      thunar-volman
      thunar-archive-plugin
      thunar-media-tags-plugin
    ];
  };
in {
  imports = [
    ./dunst
    ./polybar
    ./waybar
    ./swaylock
    ./picom
    ./mailspring
    ./wlogout
    ./mako
    ./launchers
  ];

  home.packages = with pkgs;
    [
      myThunar
      slack
      xarchiver
      evince
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
    ] ++ (if xsession.enable then [
      feh
      betterlockscreen
      thunderbird
      discord
    ] else [
      thunderbird-wayland
      webcord
      wl-clipboard
      chromium
    ]);
}
