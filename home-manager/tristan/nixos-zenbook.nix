{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    ./global

    ./features/cli
    ./features/desktop/gnome.nix
    ./features/emacs
    ./features/vim
    ./features/fonts
  ];

  home.packages = with pkgs; [
    # firefox
    brave
    bitwarden
    spotify
  ];
}
