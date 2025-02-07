{ config, lib, pkgs, ... }:

let
  myEmacsWithPkgs =
    (pkgs.emacsPackagesFor (if pkgs.stdenv.isDarwin then pkgs.emacs-macport else pkgs.emacs))
    .emacsWithPackages
      (
        epkgs: with epkgs; [
          vterm
          treesit-grammars.with-all-grammars
        ]
      );

  # myTex = (pkgs.texlive.combine {
  #   inherit (pkgs.texlive)
  #     scheme-medium dvisvgm dvipng wrapfig
  #     capt-of # amsmath ulem hyperref  latexmk
  #   ;
  # });

  doomEmacsDir = "${config.xdg.configHome}/emacs-doom";
in
rec {
  programs.emacs = {
    enable = true;
    package = myEmacsWithPkgs;
  };

  services.emacs.client.enable = false;

  home.packages = with pkgs; [
    (lib.mkIf stdenv.isDarwin coreutils-prefixed) # gls to expand dired folders
    pinentry-emacs
    emacs-all-the-icons-fonts
    (aspellWithDicts (
      dicts: with dicts; [
        en
        en-computers
        en-science
        fr
      ]
    ))
    shellcheck
    shfmt
    nixfmt-rfc-style
    rtags
    xclip
    fd
    nodejs
    # python311Packages.python-lsp-server
    # python3Full
    # poetry
    # myTex
  ];

  # home.file.".icons/doom.png".source = ./doom.png;

  xdg.desktopEntries =
    let
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
        categories = [
          "Development"
          "TextEditor"
        ];
        terminal = false;
      };
      emacs = "${programs.emacs.package}/bin/emacs";
    in
    lib.mkIf pkgs.stdenv.isLinux {
      doom-emacs = {
        name = "Doom Emacs";
        exec = "${emacs} --init-directory ${doomEmacsDir}";
        icon = ./doom.png;
      } // commonOptions;

      # nano-emacs = {
      #   name = "NANO Emacs";
      #   exec = "${emacs} --init-directory ${homeDir}/.emacs.d.nano";
      #   icon = "emacs"; # TODO
      # } // commonOptions;

      # gnu-emacs = {
      #   name = "GNU Emacs";
      #   exec = "${emacs} --init-directory ${homeDir}/.emacs.d.gnu";
      #   icon = "emacs";
      # } // commonOptions;

      emacs-minimal = {
        name = "Emacs (Minimal)";
        exec = "${emacs} --init-directory ${config.xdg.configHome}/emacs-minimal";
        icon = "emacs";
      } // commonOptions;
    };
}
