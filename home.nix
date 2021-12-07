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
    git
    tree
    gnupg
    picom
    slack
    rofi
    dracula-theme
    xfce.thunar
    alacritty
    htop
  ];


  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      starship init fish | source;
    '';
    shellAbbrs = {
      g = "git";
      gla = "git log --oneline --graph --all";
      gg = "git status";
      gr = "git rebase";
      gp = "git push";
      gpu = "git push --set-upstream origin";
      gp-f = "git push --force-with-lease";
      gF = "git pull";
      gb = "git branch";
      gbc = "git checkout -b";
      gbl = "git checkout";
      gbx = "git branch -d";
    };
    plugins = [
      {
        name = "dracula";
        src = pkgs.fetchFromGitHub {
          owner = "dracula";
          repo = "fish";
          rev = "28db361b55bb49dbfd7a679ebec9140be8c2d593";
          sha256 = "07kz44ln75n4r04wyks1838nhmhr7jqmsc1rh7am7glq9ja9inmx";
        };
      }
    ];
    functions = {
      ls = "exa $argv";
      cat = "bat $argv";
      ex = ''
        if test -f $argv
          switch $argv
            case '*.tab.bz2'
              tar xjf $argv
                case '*.tar.gz'
                  tar xzf $argv
                case '*.bz2'
                  bunzip2 $argv
                case '*.rar'
                  unrar x $argv
                case '*.gz'
                  gunzip $argv
                case '*.tar'
                  tar xvf $argv
                case '*.tbz2'
                  tar xjf $argv
                case '*.tgz'
                  tar xzf $argv
                case '*.zip'
                  unzip $argv
                case '*.Z'
                  uncompress $argv
                case '*.7z'
                  7z x $argv
                case '*'
                  echo "$argv cannot be extracted via ex()"
              end
            else
              echo "$argv is not a valid file!"
            end
      '';
    };
  };

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
