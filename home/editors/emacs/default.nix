{ config, lib, pkgs, ... }:

let
  wayland = config.modules.desktop.sessions.wayland;
  myEmacs = pkgs.emacs.override {
    nativeComp = true;
    withPgtk = wayland.enable;
  };
  myEmacsWithPkgs = (pkgs.emacsPackagesFor myEmacs).emacsWithPackages
    (epkgs: with epkgs; [ vterm ]);
in {
  programs.emacs = {
    enable = true;
    package = myEmacsWithPkgs;
  };

  services.emacs.client.enable = false;

  home.packages = with pkgs; [
    pinentry-emacs
    emacs-all-the-icons-fonts
    (aspellWithDicts (dicts: with dicts; [ en en-computers en-science ]))
    shellcheck
    rnix-lsp
    nixfmt
    rtags
    xclip
    fd
    python3Full
  ];

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
