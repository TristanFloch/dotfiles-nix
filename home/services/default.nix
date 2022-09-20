{ config, lib, pkgs, ... }:

{
  imports = [ ./wlsunset ];

  services = {
    network-manager-applet.enable = true;
    blueman-applet.enable = true;
    gpg-agent = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableSshSupport = true;
      pinentryFlavor = "gtk2";
      extraConfig = ''
        allow-emacs-pinentry
      '';
    };
  };
}
