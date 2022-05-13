{
  programs.alacritty.enable = true;

  home.file = {
    ".config/alacritty/alacritty.yml".source = ./alacritty.yml;
    ".config/alacritty/dracula.yml".source = ./dracula.yml;
  };
}
