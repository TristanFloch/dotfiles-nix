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
  programs.emacs = let wayland = config.modules.desktop.sessions.wayland;
  in {
    enable = true;
    package = if wayland.enable then
      pkgs.emacsPgtkNativeComp else
      pkgs.emacsNativeComp;
  };

  services.emacs.client.enable = false;

  home.packages = with pkgs; [
    pinentry-emacs
    emacs-all-the-icons-fonts
    bear
    (aspellWithDicts (dicts: with dicts; [ en en-computers en-science ]))
    shellcheck
    rnix-lsp
    nixfmt
    rtags
    xclip
    fd
  ];

  services.gpg-agent.pinentryFlavor = "emacs";

  xdg.desktopEntries = let
    commonOptions = {
      genericName = "Text Editor";
      comment = "Edit text";
      mimeType = [
        "text/english"
        "text/plain"
        "text/x-makefile"
        "text/x-c++hdr"
        "text/x-c++src"
        "text/x-chdr"
        "text/x-csrc"
        "text/x-java"
        "text/x-moc"
        "text/x-pascal"
        "text/x-tcl"
        "text/x-tex"
        "application/x-shellscript"
        "text/x-c"
        "text/x-c++"
      ];
      categories = [ "Development" "TextEditor" ];
      terminal = false;
      # settings = {
      #   StartupWmClass = "Emacs"; # FIXME
      # };
    };
  in {
    doom-emacs = {
      name = "Doom Emacs";
      exec = "emacs --with-profile doom";
      icon = "doom";
    } // commonOptions;

    nano-emacs = {
      name = "NANO Emacs";
      exec = "emacs --with-profile nano";
      icon = "emacs"; # TODO
    } // commonOptions;

    gnu-emacs = {
      name = "GNU Emacs";
      exec = "emacs --with-profile gnu";
      icon = "emacs";
    } // commonOptions;
  };

  home.file.".icons/doom.png".source = ./doom.png;
}
