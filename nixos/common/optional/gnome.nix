{ config, lib, pkgs, ... }:

{
  # Enable the GNOME Desktop Environment.
  services = {
    xserver = {
      enable = true;

      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      layout = "us";
      xkbVariant = "altgr-intl";

      libinput.enable = true;
    };
    geoclue2.enable = true;
  };

  environment = {
    gnome.excludePackages = (with pkgs; [ gnome-tour ]) ++ (with pkgs.gnome; [
      cheese # webcam tool
      epiphany # web browser
      gedit # text editor
      # geary # email reader
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]);
  };

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services = {
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };
}
