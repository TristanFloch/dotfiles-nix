{ config, lib, pkgs, ... }:

{
  imports = [ ./bat ./direnv ./fish ./starship ];

  home.packages = with pkgs; [
    exa
    fd
    bc
    tree
    killall
    jq
    man-pages
    man-pages-posix
    binutils
    fzf
    escrotum
    ripgrep
    neofetch
    unzip
    cmatrix
    unixtools.ping
  ];
}
