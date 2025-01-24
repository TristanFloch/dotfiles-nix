{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.mac-app-util.homeManagerModules.default

    ./global

    ./features/cli
  ];

  programs.git.signing.key = "B9C345A15CF94A2E1BFCBEB71E59FE6862711F56";

  home = {
    username = "tristan";
    homeDirectory = "/Users/${config.home.username}";
    stateVersion = "24.11";

    packages = with pkgs; [
      spotify
      discord
    ];
  };
}
