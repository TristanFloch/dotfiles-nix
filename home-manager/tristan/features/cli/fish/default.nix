{ config, lib, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
      # set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
      # fish_add_path ~/.emacs.d.doom/bin/
    '';

    shellAbbrs = { } // import ./gitAbbrs.nix;

    shellAliases = {
      # nix-shell = "nix-shell --run fish";
    };

    plugins = import ./plugins.nix {
      inherit config;
      inherit pkgs;
    };

    functions = {
      ls = "${pkgs.exa}/bin/exa $argv";
      lls = "${pkgs.coreutils}/bin/ls $argv";
      cat = "${pkgs.bat}/bin/bat $argv";
      ccat = "${pkgs.coreutils}/bin/cat $argv";
      tree = "${pkgs.exa}/bin/exa --tree $argv";
      ttree = "${pkgs.tree}/bin/tree $argv";
      ex = {
        body = builtins.readFile ./functions/ex.fish;
        description = "extracts any archive format";
      };
      # monitor = {
      #   body = builtins.readFile ./functions/monitor.fish;
      #   description = "connects/disconnects pluged/unpluged monitors";
      # };
      fish_user_key_bindings = {
        body = ''
          fish_default_key_bindings -M insert
          fish_vi_key_bindings --no-erase insert
        '';
      };
    };
  };

  # programs.nix-index = {
  #   enable = true;
  #   enableFishIntegration = true;
  # };
}
