{ config, lib, pkgs, ... }:

{
  # Enable the GNOME Desktop Environment.
  services = {
    xserver = {
      enable = true;

      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      xkb = {
        layout = "us";
        variant = "altgr-intl";
      };

    };
    geoclue2.enable = true;
    libinput.enable = true;
  };

  environment = {
    gnome.excludePackages = with pkgs; [
      gnome-tour
      cheese # webcam tool
      epiphany # web browser
      geary # email reader
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ];
  };

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services = {
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };
}
