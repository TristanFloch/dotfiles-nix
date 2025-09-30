{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./global

    ./features/cli
    ./features/fonts
    ./features/vim
    ./features/emacs
    ./features/terminal
  ];

  home = {
    username = "tristan.floch";
    homeDirectory = "/Users/${config.home.username}";
    stateVersion = "24.11";

    sessionPath = [
      "/opt/homebrew/opt/llvm@20/bin"
      "/Users/tristan.floch/Code/bin"
    ];
  };

  programs.git = {
    signing.key = "26FFD2B1B8E8DBC23273163B823513B4C3E5E849";
    userEmail = "tristan.floch@algolia.com";
    lfs.enable = true;
    extraConfig = {
      url."git@github.com:".insteadOf = "https://github.com/";
    };
    includes = [
      {
        path = "~/.config/git/secrets";
      }
    ];
  };

  programs.k9s.enable = true;

  xdg.configFile."ccache/ccache.conf".text = ''
    # Set maximum cache size to 50 GB:
    max_size = 50G
    # To prevent wrong warnings, redo the preproc step in case of cache miss
    run_second_cpp = true
    # Base the cache key on the preprocessed file instead of source file for obvious reason
    direct_mode = false
    # Include the current working directory in the hash
    hash_dir = true
  '';
}
