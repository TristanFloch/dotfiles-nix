{ config, lib, pkgs, self, ... }:

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

    primaryUser = "tristan";
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  networking.hostName = "macbook-pro-m4";

  security.pam.services.sudo_local.touchIdAuth = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  homebrew = {
    brews = [ ];
    casks = [ ];
  };
}
