{ config, lib, pkgs, ... }:

let
  ifTheyExist = groups:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tristan = {
    isNormalUser = true;
    description = "Tristan Floch";
    extraGroups = [ "wheel" "video" "audio" ] ++ ifTheyExist [
      "dialout"
      "docker"
      "git"
      "networkmanager"
      "podman"
      "wireshark"
    ];

    packages = [ pkgs.home-manager ];
  };

  home-manager.users.tristan =
    import ../../../../home-manager/tristan/${config.networking.hostName}.nix;

  services.xserver.displayManager.autoLogin.user =
    "tristan"; # set even if autoLogin is disabled
}
