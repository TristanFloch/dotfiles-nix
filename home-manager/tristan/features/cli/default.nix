{ lib, config, pkgs, ... }:
{
  imports = [
    ./atuin
    ./bat
    ./direnv
    ./fish
    ./git
    ./htop
    ./starship
  ];

  home.packages = with pkgs; [
    eza
    fd
    ripgrep
    jq
    tree
    killall
    man-pages
    man-pages-posix
    unixtools.ping
    unzip
    cmatrix
    neofetch
    sshs
  ];
}
