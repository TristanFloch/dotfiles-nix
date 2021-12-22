{ config, lib, pkgs, ... }:

# FIXME: problem in nix-doom-emacs
# let
#   doom-emacs = pkgs.callPackage (builtins.fetchTarball {
#     url = https://github.com/vlaci/nix-doom-emacs/archive/develop.tar.gz;
#   }) {
#     doomPrivateDir = ./doom.d;
#   };
# in {
#   home.packages = [ doom-emacs ];
#   home.file.".emacs.d/init.el".text = ''
#     (load "default.el")
#   '';
# }

{
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
    rnix-lsp
  ];

  services.gpg-agent.pinentryFlavor = "emacs";
}
