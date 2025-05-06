{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./global

    ./features/cli
    ./features/desktop/yabai
    ./features/fonts
    ./features/vim
    ./features/emacs
    ./features/terminal
  ];

  programs.git.signing.key = "B9C345A15CF94A2E1BFCBEB71E59FE6862711F56";

  home = {
    username = "tristan";
    homeDirectory = "/Users/${config.home.username}";
    stateVersion = "24.11";
  };
}
