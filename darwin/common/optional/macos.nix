{ config, lib, pkgs, ... }:

{
  system.defaults = {
    controlcenter = {
      AirDrop = false;
      BatteryShowPercentage = true;
      Bluetooth = false;
      Display = false;
      FocusModes = false;
      NowPlaying = true;
      Sound = false;
    };

    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      FXDefaultSearchScope = "SCcf"; # search under current folder
      FXRemoveOldTrashItems = true;
      QuitMenuItem = true;
      ShowExternalHardDrivesOnDesktop = false;
      ShowHardDrivesOnDesktop = false;
      ShowMountedServersOnDesktop = false;
      ShowPathbar = true;
      ShowRemovableMediaOnDesktop = true;
      ShowStatusBar = true;
      _FXShowPosixPathInTitle = true;
      _FXSortFoldersFirst = true;
    };

    hitoolbox = {
      AppleFnUsageType = "Show Emoji & Symbols";
    };

    loginwindow = {
      GuestEnabled = false;
    };

    menuExtraClock = {
      ShowDate = 0; # when space allowed
    };

    NSGlobalDomain = {
      AppleEnableSwipeNavigateWithScrolls = true;

      AppleInterfaceStyleSwitchesAutomatically = true;

      AppleShowAllExtensions = true;

      NSAutomaticInlinePredictionEnabled = true;
      NSAutomaticDashSubstitutionEnabled = true;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = true;

      NSAutomaticWindowAnimationsEnabled = true;

      NSDocumentSaveNewDocumentsToCloud = false;
      NSWindowShouldDragOnGesture = true;

      "com.apple.mouse.tapBehavior" = 1;
      "com.apple.trackpad.enableSecondaryClick" = true;
      "com.apple.trackpad.forceClick" = false;
      "com.apple.swipescrolldirection" = false;
    };

    screencapture = {
      location = "~/Pictures/Screenshots";
      target = "clipboard";
    };

    screensaver = {
      askForPassword = false;
      askForPasswordDelay = 5;
    };

    spaces.spans-displays = false; # each physical display has a separate space

    trackpad = {
      ActuationStrength = 1; # haptic feedback on force click
      Clicking = true; # tap to click
      Dragging = true;
      TrackpadRightClick = true;
      TrackpadThreeFingerDrag = false;
      TrackpadThreeFingerTapGesture = 2;
      SecondClickThreshold = 0;
    };

    WindowManager = {
      EnableTiledWindowMargins = true;
      EnableTilingByEdgeDrag = true;
      EnableTilingOptionAccelerator = true;
      EnableTopTilingByEdgeDrag = true;
      GloballyEnabled = false;
      HideDesktop = true;
      StageManagerHideWidgets = true;
      StandardHideDesktopIcons = false;
      StandardHideWidgets = false;
    };
  };
}
