{ config, lib, pkgs, ... }:

{
  imports = [ ./desktop ./services ];

  config = let wayland = config.modules.desktop.sessions.wayland;
  in {
    environment.systemPackages = with pkgs; [
      vim
      wget
      (if wayland.enable then firefox-wayland else firefox)
      ntfs3g
      exfat
      nfs-utils
      protonvpn-gui
      protonvpn-cli_2
      openvpn
      hey
    ];
  };
}
