{ config, pkgs, ... }:

{
  home = {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "tristan";
    homeDirectory = "/home/tristan";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "21.11";

    sessionVariables = {
      EDITOR = "vim";
    };
  };

  imports = [
    ./starship
    ./bat
    ./fish
    ./git
    ./vim
    ./alacritty
    ./gtk
    ./rofi
    ./picom
    ./polybar
    ./dunst
    ./emacs
    ./i3
    ./xresources
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    exa
    fd
    tree
    gnupg
    picom
    slack
    dracula-theme
    xfce.thunar
    alacritty
    htop
    fzf
    unzip
    ripgrep
    evince
    killall
    thunderbird
    pavucontrol
    spotify
    feh
    jq
    brightnessctl
    unixtools.ping
    neofetch

    pythonFull
    binutils
    gcc
    clang-tools
    gnumake
    cmake
    criterion

    noto-fonts noto-fonts-emoji dejavu_fonts hack-font nerdfonts
  ];

  services = {
    # Applets, shown in tray
    network-manager-applet.enable = true;
    # blueman-applet.enable = true;
    pasystray.enable = true;
  };

  fonts.fontconfig.enable = true;
}
