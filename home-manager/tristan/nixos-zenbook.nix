{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    ./global

    ./features/cli
    ./features/emacs
    ./features/vim
    ./features/fonts
  ];

  home.packages = with pkgs; [
    firefox
  ];
}
