{ config, pkgs, ... }:
{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
      set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
      fish_add_path ~/.emacs.d.doom/bin/
    '';

    shellAbbrs = {
      intl = "setxkbmap us_intl";
      us = "setxkbmap us";
    } // import ./gitAbbrs.nix;

    shellAliases = {
      nix-shell = "nix-shell --run fish";
    };

    plugins = import ./plugins.nix pkgs;

    functions = {
      ls = "exa $argv";
      cat = "bat $argv";
      ex = {
        body = builtins.readFile ./functions/ex.fish;
        description = "extracts any archive format";
      };
      monitor = {
        body = builtins.readFile ./functions/monitor.fish;
        description = "connects/disconnects pluged/unpluged monitors";
      };
      config = {
        body = builtins.readFile ./functions/config.fish;
        description = "shorthands for nixos-rebuild options";
      };
    };
  };

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };
}
