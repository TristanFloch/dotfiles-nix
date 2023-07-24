{ lib, config, pkgs, ... }:
{
  imports = [
    ./bat
    ./direnv
    ./fish
    ./starship
  ];

  home.packages = with pkgs; [
    exa
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
  ];
}
