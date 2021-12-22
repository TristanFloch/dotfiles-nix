{ config, lib, pkgs, ... }:

# FIXME: problem in nix-doom-emacs
# let
#   doom-emacs = pkgs.callPackage (builtins.fetchTarball {
#     url = https://github.com/vlaci/nix-doom-emacs/archive/develop.tar.gz;
#   }) {
#     doomPrivateDir = ./doom.d;
#   };
# in {
#   nixpkgs.overlays = [
#     (import (builtins.fetchTarball {
#       url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
#     }))
#   ];
#   home.packages = [ doom-emacs ];
#   home.file.".emacs.d/init.el".text = ''
#     (load "default.el")
#   '';
# }

{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacsGcc;
  };

  home.packages = with pkgs; [
    pinentry-emacs
    emacs-all-the-icons-fonts
    bear
    aspell
    shellcheck
  ];

  services.gpg-agent.pinentryFlavor = "emacs";
}
