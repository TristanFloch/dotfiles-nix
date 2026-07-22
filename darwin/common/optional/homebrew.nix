{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];

  # Install and manage the Homebrew installation itself
  nix-homebrew = {
    enable = true;
    user = config.system.primaryUser;
    # Adopt a Homebrew installation that predates nix-homebrew
    autoMigrate = true;
  };

  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global = {
      # Refresh formula/cask metadata and taps when running brew commands (not brew itself, managed by nix-homebrew)
      autoUpdate = true;
    };
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = config.programs.fish.enable;
    # brews = [
    #   {
    #     name = "emacs-mac";
    #     args = [
    #       "with-dbus"
    #       "with-imagemagick"
    #       "with-librsvg"
    #       "with-mac-metal"
    #       "with-native-comp"
    #        # https://github.com/railwaycat/homebrew-emacsmacport/blob/master/icons/
    #       "with-modern-icon"
    #     ];
    #     # XXX: run `cp -a $(brew --prefix)/opt/emacs-mac/Emacs.app /Applications`
    #   }
    # ];
    # taps = [
    #   "railwaycat/emacsmacport"
    #   "koekeishiya/formulae"
    # ];
  };
}
