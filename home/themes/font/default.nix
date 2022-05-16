{ config, lib, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    dejavu_fonts
    nerdfonts
    roboto
    roboto-mono
    victor-mono
    ubuntu_font_family
    source-code-pro
  ];
}
