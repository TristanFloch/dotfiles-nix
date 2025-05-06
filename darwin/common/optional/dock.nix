{ config, lib, pkgs, ... }:

{
  system.defaults.dock = {
    appswitcher-all-displays = false;
    autohide = true;
    dashboard-in-overlay = true;
    expose-animation-duration = 1.2;
    expose-group-apps = true;
    minimize-to-application = true;
    mru-spaces = false;
    orientation = "bottom";
    # persistent-apps =
    #   let
    #     hmConfig = config.home-manager.users.tristan;
    #   in
    #   [
    #     "/Applications/Emacs.app"
    #     "/Applications/Safari.app"
    #     (lib.mkIf hmConfig.programs.ghostty.enable "/Applications/Ghostty.app")
    #     "/System/Applications/Calendar.app"
    #     "/System/Applications/Messages.app"
    #     "/Applications/WhatsApp.app"
    #     "/System/Applications/Mail.app"
    #     "/Applications/Spotify.app"
    #     "/System/Applications/System Settings.app"
    #   ];
    scroll-to-open = true;
    show-process-indicators = true;
    show-recents = false;
    tilesize = 56;
    wvous-bl-corner = 3; # application windows
    wvous-br-corner = 4; # desktop
    wvous-tl-corner = 2; # mission control
    wvous-tr-corner = 12; # notification center
  };
}
