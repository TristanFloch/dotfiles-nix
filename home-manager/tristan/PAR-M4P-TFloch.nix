{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./global

    ./features/cli
    ./features/fonts
    ./features/vim
    ./features/emacs
    ./features/terminal
  ];

  programs.git.signing.key = "26FFD2B1B8E8DBC23273163B823513B4C3E5E849";

  home = {
    username = "tristan.floch";
    homeDirectory = "/Users/${config.home.username}";
    stateVersion = "24.11";
  };
}
