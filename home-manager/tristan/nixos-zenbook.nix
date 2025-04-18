{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    ./global

    ./features/linux
    ./features/cli
    ./features/desktop/gnome
    ./features/emacs
    ./features/vim
    ./features/fonts
  ];

  home.packages = with pkgs; [
    firefox
    # brave
    spotify
    stremio
    discord
  ];

  programs.git.signing.key = "8385C2FDF60DEA0F8E4DC84332E6FC93EFC1B42F";
}
