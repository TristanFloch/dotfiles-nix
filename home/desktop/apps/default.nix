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

  # Pick a display to mirror using wl-mirror and slurp
  wl-mirror-pick = pkgs.writeShellApplication {
    name = "wl-mirror-pick";
    runtimeInputs = with pkgs; [ slurp wl-mirror ];
    text = # bash
      ''
        output=$(slurp -f "%o" -o)
        wl-mirror "$output"
      '';
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
      wl-mirror
      wl-mirror-pick
      slurp
      grim
      chromium
    ]);
}
