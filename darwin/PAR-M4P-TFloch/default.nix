{
  config,
  lib,
  pkgs,
  self,
  ...
}:

{
  imports = [
    ../common/global

    ../common/users/tristan

    ../../nixos/common/optional/fish.nix

    ../common/optional/macos.nix
    ../common/optional/dock.nix
    ../common/optional/homebrew.nix
  ];

  system = {
    # Set Git commit hash for darwin-version.
    configurationRevision = self.rev or self.dirtyRev or null;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 5;

    primaryUser = "tristan.floch";
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  networking.hostName = "PAR-M4P-TFloch"; # set by my company

  security.pam.services.sudo_local.touchIdAuth = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  homebrew = {
    brews = [ ];
    casks = [ ];
  };

  users.users.tristan = {
    name = "tristan.floch";
    home = "/Users/tristan.floch";
  };

  environment = {
    variables = {
      VAULT_ADDR = "https://vault.algolia.net";

      CC = "/opt/homebrew/opt/llvm@20/bin/clang";
      CXX = "/opt/homebrew/opt/llvm@20/bin/clang++";

      GOPATH = "/Users/tristan.floch/Code/go";

      AUSER = "tfloch";
    };

    systemPath = [
      "/opt/homebrew/opt/lld@20/bin"
      "/opt/homebrew/opt/llvm@20/bin"
      "/Users/tristan.floch/Code/go/bin"
    ];
  };
}
