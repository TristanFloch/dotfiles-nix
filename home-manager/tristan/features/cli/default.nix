{
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./atuin
    ./bat
    ./direnv
    ./fish
    ./git
    ./htop
    ./pyenv
    ./starship
  ];

  home.packages = with pkgs; [
    eza
    fd
    ripgrep
    jq
    tree
    killall
    man-pages
    man-pages-posix
    unixtools.ping
    unzip
    cmatrix
    fastfetch
    sshs
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    # sops on macOS defaults to ~/Library/Application Support/sops; keep the key XDG-style
    SOPS_AGE_KEY_FILE = "${config.xdg.configHome}/sops/age/keys.txt";
  };

  programs.nix-your-shell = {
    enable = true;
    enableFishIntegration = true;
  };
}
