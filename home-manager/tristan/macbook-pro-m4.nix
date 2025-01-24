{ config, lib, pkgs, ... }:

{
  imports = [
    ./global

    ./features/cli
  ];

  home = {
    username = "tristan";
    homeDirectory = "/Users/${config.home.username}";
    stateVersion = "24.11";
  };

  programs.git.signing.key = "B9C345A15CF94A2E1BFCBEB71E59FE6862711F56";
}
