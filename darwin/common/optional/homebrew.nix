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
      brews = [
        "yabai"
        "skhd"

        {
          name = "emacs-mac";
          args = [
            "with-dbus"
            "with-imagemagick"
            "with-librsvg"
            "with-mac-metal"
            "with-native-comp"
          ];
          # TODO: run `cp -a $(brew --prefix)/opt/emacs-mac/Emacs.app /Applications`
        }
      ];
      casks = [
        "raycast"
        (lib.mkIf hmConfig.programs.ghostty.enable "ghostty")
      ];
      taps = [
        "railwaycat/emacsmacport"
        "koekeishiya/formulae"
      ];
    };
}
