{ config, lib, pkgs, self, ... }:

{
  imports = [
    ../common/global

    ../../nixos/common/optional/fish.nix

    ../common/optional/macos.nix
    ../common/optional/dock.nix
    ../common/optional/homebrew.nix
  ];

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  system = {
    # Set Git commit hash for darwin-version.
    configurationRevision = self.rev or self.dirtyRev or null;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 5;
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  networking.hostName = "PAR-M4P-TFloch"; # set by my company

  security.pam.enableSudoTouchIdAuth = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  homebrew = {
    brews = [];
    casks = [
      "spotify"
      "whatsapp"
      "messenger"
    ];
  };

  users.users."tristan.floch" = {
    name = "tristan.floch";
    description = "Tristan Floch";
    home = "/Users/tristan.floch";
    packages = [ pkgs.home-manager ];
  };

  home-manager.users."tristan.floch" =
    import ../../home-manager/tristan/${config.networking.hostName}.nix;
}
