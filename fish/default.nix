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

      g = "git";
      gs = "git stage";
      gu = "git restore --staged";
      ga = "git add";
      gC = "git clone";
      gc = "git commit";
      gcf = "git commit --fixup";
      gcs = "git commit --squash";
      gl = "git log --oneline --graph";
      gla = "git log --oneline --graph --all";
      gg = "git status";
      gr = "git rebase";
      gri = "git rebase --interactive";
      gp = "git push";
      gpu = "git push --set-upstream origin";
      gp-f = "git push --force-with-lease";
      gf = "git fetch";
      gF = "git pull";
      gb = "git branch";
      gbb = "git switch";
      gbc = "git checkout -b";
      gbl = "git checkout";
      gbx = "git branch -d";
      go = "git reset";
      gOh = "git reset --hard";
      gOs = "git reset --soft";
    };
    plugins = [
      {
        # FIXME
        name = "done";
        src = pkgs.fishPlugins.done;
      }
      {
        name = "dracula";
        src = pkgs.fetchFromGitHub {
          owner = "dracula";
          repo = "fish";
          rev = "28db361b55bb49dbfd7a679ebec9140be8c2d593";
          sha256 = "07kz44ln75n4r04wyks1838nhmhr7jqmsc1rh7am7glq9ja9inmx";
        };
      }
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "45a9ff6d0932b0e9835cbeb60b9794ba706eef1";
          sha256 = "1kjyl4gx26q8175wcizvsm0jwhppd00rixdcr1p7gifw6s308sd5";
        };
      }
      {
        name = "fish-async-prompt";
        src = pkgs.fetchFromGitHub {
          owner = "acomagu";
          repo = "fish-async-prompt";
          rev = "40f30a4048b81f03fa871942dcb1671ea0fe7a53";
          sha256 = "19i59145lsjmidqlgk2dmvs3vg2m3zlz2rcms2kyyk1m3y63q8xi";
        };
      }
    ];
    functions = {
      ls = "exa $argv";
      cat = "bat $argv";
      ex = builtins.readFile ./functions/ex.fish;
      monitor = builtins.readFile ./functions/monitor.fish;
    };
  };
}
