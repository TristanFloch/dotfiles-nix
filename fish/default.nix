{ config, pkgs, ... }:
{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
      starship init fish | source;
    '';

    shellAbbrs = {
      doom = "~/.emacs.d/bin/doom";
      intl = "setxkbmap us_intl";
      us = "setxkbmap us";
      apply = "~/.config/nixpkgs/apply.sh";

      flow = "nix run .#check-workflow";

    } // import ./gitAbbrs.nix;

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
    };
  };

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };
}
