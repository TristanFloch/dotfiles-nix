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
  # Updating homebrew: `nix flake update nix-homebrew` and rebuild config
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
    #     name = "railwaycat/emacsmacport/emacs-mac@30exp";
    #     args = [
    #       "with-dbus"
    #       "with-imagemagick"
    #       "with-librsvg"
    #       "with-mac-metal"
    #       "with-unlimited-select"
    #        # https://github.com/railwaycat/homebrew-emacsmacport/blob/master/icons/
    #       "with-emacs-big-sur-icon"
    #     ];
    #     # XXX: run `cp -a /opt/homebrew/opt/emacs-mac@30exp/Emacs.app /Applications`
    #   }
    # ];
    # taps = [
    #   "railwaycat/emacsmacport"
    #   "koekeishiya/formulae"
    # ];
  };
}
