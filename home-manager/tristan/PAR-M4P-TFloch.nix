{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

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

    sessionVariables = {
      VAULT_ADDR = "https://vault.algolia.net";
      AUSER = "tfloch";
      GOPATH = "${config.home.homeDirectory}/Code/go";
    };

    sessionPath = [
      "${config.home.sessionVariables.GOPATH}/bin"
      "${config.home.homeDirectory}/.local/bin"
      "${config.home.homeDirectory}/.swiftly/bin"
    ];
  };

  programs.git = {
    settings = {
      user.email = "tristan.floch@algolia.com";
      url."git@github.com:".insteadOf = "https://github.com/";
      gpg = {
        format = "ssh";
        ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"; # use ssh-agent from 1password
      };
    };
    signing.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGooRy/CxVJB0qRSgSw5DsGgxtWYvTm5/Ua4rKZvtcXQ";
    lfs.enable = true;
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
