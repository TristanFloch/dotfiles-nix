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

    file = {
      ".config/alacritty/alacritty.yml".source = ./alacritty/alacritty.yml;
    };
  };

  imports = [
    ./fish/config.nix
  ];

  gtk = {
    # FIXME
    enable = true;
    theme.name = "Dracula";
    theme.package = pkgs.dracula-theme;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    exa
    fd
    bat
    tree
    gnupg
    picom
    slack
    rofi
    dracula-theme
    xfce.thunar
    alacritty
    htop
    fzf
  ];

  programs.git = {
    enable = true;
    userName = "Tristan FLOCH";
    userEmail = "tristan.floch@epita.fr";
  };

  programs.vim = {
    enable = true;
    settings = { 
      ignorecase = true; 
      background = "dark";
    };
    plugins = with pkgs.vimPlugins; [ 
      lightline-vim
      dracula-vim
    ];
    extraConfig = ''
      set mouse=a
      set rnu
      set scrolloff=10
      let g:lightline = { 'colorscheme': 'dracula' }
    '';
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    settings = {
      add_newline = true;
      character = {
        success_symbol = "[➜](bold purple)";
      };
      line_break.disabled = true;
    };
  };

  programs.bat = {
    enable = true;
    config = { theme = "Dracula"; };
    themes = { dracula = builtins.readFile (pkgs.fetchFromGitHub {
        owner = "dracula";
        repo = "sublime"; # Bat uses sublime syntax for its themes
        rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
        sha256 = "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
      } + "/Dracula.tmTheme");
    };
  };
}
