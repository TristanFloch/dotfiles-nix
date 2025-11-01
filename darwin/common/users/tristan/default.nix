{
  config,
  lib,
  pkgs,
  ...
}:

let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tristan = {
    name = lib.mkDefault "tristan";
    description = "Tristan Floch";
    home = lib.mkDefault "/Users/tristan";
    packages = [ pkgs.home-manager ];
  };

  home-manager.users.tristan = import ../../../../home-manager/tristan/${config.networking.hostName}.nix;
}
