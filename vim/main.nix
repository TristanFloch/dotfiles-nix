{ config, pkgs, ... }:
{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      lightline-vim
      dracula-vim
      vim-commentary
      fzf-vim
      auto-pairs
    ];
    extraConfig = builtins.readFile ./vimrc;
  };
}
