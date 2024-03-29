{ config, lib, pkgs, ... }:

let
  material-design-icon-desktop = pkgs.fetchFromGitHub {
    name = "material-design-icons-desktop";
    repo = "MaterialDesign-Font";
    owner = "Templarian";
    rev = "d72e30826e6797c1b3a2976e71d0d2f790c1a2eb";
    sha256 = "sha256-8QCexkEErGh72+CkXXxBVlJI8NpN6VtI9nwp0DOYGDs=";

    postFetch = ''
      mkdir -p $out/share/fonts/truetype
      cp $out/MaterialDesignIconsDesktop.ttf $out/share/fonts/truetype/
    '';
  };
in {
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
    material-design-icon-desktop
  ];
}
