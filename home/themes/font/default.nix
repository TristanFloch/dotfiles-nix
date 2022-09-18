{ config, lib, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  xdg.configFile."fontconfig/fonts.conf".text = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
    <fontconfig>
      <alias>
        <family>alacritty</family>
        <prefer>
          <family>Source Code Pro</family>
          <family>Noto Color Emoji</family>
        </prefer>
      </alias>
    </fontconfig>
  '';

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
