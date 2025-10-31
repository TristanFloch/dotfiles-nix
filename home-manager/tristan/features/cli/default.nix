{
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./atuin
    ./bat
    ./direnv
    ./fish
    ./git
    ./htop
    ./pyenv
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

  home.sessionVariables = {
    EDITOR = "vim";
  };
}
