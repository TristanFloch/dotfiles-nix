{ config, lib, pkgs, ... }:

{
  let
    doom-emacs = pkgs.callPackage (builtins.fetchTarball {
      url = https://github.com/vlaci/nix-doom-emacs/archive/master.tar.gz;
    }) {
      doomPrivateDir = ./doom.d
    };
  in {
    home.file.".emacs.d/init.el".text = ''
      (load "default.el")
    '';
    programs.doom-emacs = {
      enable = true;
      emacsPackage = pkgs.emacsGcc;
    }
  }
}
