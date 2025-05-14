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
  };

  programs.fish.shellInit = ''
    export VAULT_ADDR=https://vault.algolia.net

    export CC=/opt/homebrew/opt/llvm@19/bin/clang
    export CXX=/opt/homebrew/opt/llvm@19/bin/clang++

    fish_add_path /opt/homebrew/opt/llvm@19/bin
    fish_add_path /opt/homebrew/opt/lld@19/bin
  '';

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
