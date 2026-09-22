{
  config,
  lib,
  pkgs,
  ...
}:

let
  myEmacsWithPkgs = (pkgs.emacsPackagesFor pkgs.emacs).emacsWithPackages (
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
    enable = pkgs.stdenv.isLinux; # install using homebrew otherwise
    package = myEmacsWithPkgs;
  };

  services.emacs.client.enable = false;

  home.sessionPath = [
    "${doomEmacsDir}/bin"
  ];

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
    nixfmt
    rtags
    xclip
    fd
    nodejs
    claude-agent-acp
    dockerfile-language-server
    svelte-language-server
    tailwindcss-language-server
    # myTex
  ];

  # home.file.".icons/doom.png".source = ./doom.png;

  xdg.desktopEntries = lib.mkIf pkgs.stdenv.isLinux (
    import ./xdg-desktop-entries.nix {
      inherit config;
      inherit doomEmacsDir;
    }
  );
}
