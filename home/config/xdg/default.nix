{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ xdg_utils ];
  xdg = {
    enable = true;
    configFile."nixpkgs/config.nix".text = ''
      {
        allowUnfree = true;
      }
    '';
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = [ "org.gnome.Evince.desktop" ];
        "image/png" = [ "viewnior.desktop" ];
        "image/jpeg" = [ "viewnior.desktop" ];

        # auto generated
        "x-scheme-handler/mailto" = [ "userapp-Thunderbird-RTR3D1.desktop" ];
        "message/rfc822" = [ "userapp-Thunderbird-RTR3D1.desktop" ];
        "x-scheme-handler/mid" = [ "userapp-Thunderbird-RTR3D1.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
        "x-scheme-handler/chrome" = [ "firefox.desktop" ];
        "text/html" = [ "firefox.desktop" ];
        "application/x-extension-htm" = [ "firefox.desktop" ];
        "application/x-extension-html" = [ "firefox.desktop" ];
        "application/x-extension-shtml" = [ "firefox.desktop" ];
        "application/xhtml+xml" = [ "firefox.desktop" ];
        "application/x-extension-xhtml" = [ "firefox.desktop" ];
        "application/x-extension-xht" = [ "firefox.desktop" ];
        "x-scheme-handler/msteams" = [ "teams.desktop" ];
        "x-scheme-handler/mailspring" = [ "Mailspring.desktop" ];
      };

      associations.added = {
        # auto generated
        "x-scheme-handler/mailto" = [ "userapp-Thunderbird-RTR3D1.desktop" ];
        "x-scheme-handler/mid" = [ "userapp-Thunderbird-RTR3D1.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
        "x-scheme-handler/chrome" = [ "firefox.desktop" ];
        "text/html" = [ "firefox.desktop" ];
        "application/x-extension-htm" = [ "firefox.desktop" ];
        "application/x-extension-html" = [ "firefox.desktop" ];
        "application/x-extension-shtml" = [ "firefox.desktop" ];
        "application/xhtml+xml" = [ "firefox.desktop" ];
        "application/x-extension-xhtml" = [ "firefox.desktop" ];
        "application/x-extension-xht" = [ "firefox.desktop" ];
        "application/zip" = [ "userapp-unzip-YDGVG1.desktop" ];
        "application/pdf" = [
          "userapp-evince-FZ2CH1.desktop"
          "userapp-evince-XX4BS1.desktop"
          "userapp-evince-QMLES1.desktop"
        ];
        "image/png" = [ "feh.desktop" "org.xfce.ristretto.desktop" ];
        "image/jpeg" = [ "viewnior.desktop" ];
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" =
          [ "emacs.desktop" "firefox.desktop" ];
      };
    };
  };
}
