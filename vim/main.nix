{
  programs.vim = {
    enable = true;
    settings = {
      ignorecase = true;
      background = "dark";
    };
    plugins = with pkgs.vimPlugins; [
      lightline-vim
      dracula-vim
    ];
    extraConfig = ''
      set mouse=a
      set rnu
      set scrolloff=10
      let g:lightline = { 'colorscheme': 'dracula' }
    '';
  };
}
