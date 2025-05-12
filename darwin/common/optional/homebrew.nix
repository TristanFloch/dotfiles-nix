{ config, lib, pkgs, ... }:

{
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global = {
      autoUpdate = true; # brew will update itself when running brew commands
    };
    brews = [
      {
        name = "emacs-mac";
        args = [
          "with-dbus"
          "with-imagemagick"
          "with-librsvg"
          "with-mac-metal"
          "with-native-comp"
        ];
        # XXX: run `cp -a $(brew --prefix)/opt/emacs-mac/Emacs.app /Applications`
      }
    ];
    casks = [
      "raycast"
      "ghostty"
    ];
    taps = [
      "railwaycat/emacsmacport"
      "koekeishiya/formulae"
    ];
  };
}
