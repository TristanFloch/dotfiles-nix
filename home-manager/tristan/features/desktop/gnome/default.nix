{ pkgs, ... }:

{
  imports = [ ../common ];

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;

      # `gnome-extensions list`
      enabled-extensions = [
        "drive-menu@gnome-shell-extensions.gcampax.github.com"
        "gsconnect@andyholmes.github.io"
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        "pano@elhan.io"
        "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com"
        "trayIconsReloaded@selfmade.pl"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        "focus-changer@heartmire"
        "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
        # "Vitals@CoreCoding.com"
        # "forge@jmmaranan.com"
        # "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
      ];
    };
  };

  home.packages = with pkgs.gnomeExtensions; [
    auto-move-windows
    focus-changer
    forge
    gsconnect
    pano
    tray-icons-reloaded
    user-themes
    vitals
  ];
}
