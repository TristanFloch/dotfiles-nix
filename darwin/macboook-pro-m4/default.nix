{ config, lib, pkgs, self, ... }:

{
  imports = [
    ../common/global

    ../../nixos/common/optional/fish.nix
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
}
