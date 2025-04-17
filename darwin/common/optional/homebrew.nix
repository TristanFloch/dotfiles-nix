{ config, lib, pkgs, ... }:

{
  homebrew =
    let
      hmConfig = config.home-manager.users.tristan;
    in
    {
      enable = true;
      caskArgs.no_quarantine = true;
      global = {
        autoUpdate = true; # brew will update itself when running brew commands
      };
      brews = [ ];
      casks = [
        "emacs-mac"
        "raycast"
        (lib.mkIf hmConfig.programs.ghostty.enable "ghostty")
      ];
      taps = [ "railwaycat/emacsmacport" ];
    };
}
