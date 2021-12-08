{ config, pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      starship init fish | source;
    '';
    shellAbbrs = {
      g = "git";
      gs = "git stage";
      gu = "git restore --staged";
      gc = "git commit";
      gcf = "git commit --fixup";
      gcs = "git commit --squash";
      gla = "git log --oneline --graph --all";
      gg = "git status";
      gr = "git rebase";
      gp = "git push";
      gpu = "git push --set-upstream origin";
      gp-f = "git push --force-with-lease";
      gF = "git pull";
      gb = "git branch";
      gbc = "git checkout -b";
      gbl = "git checkout";
      gbx = "git branch -d";
    };
    plugins = [
      {
        name = "dracula";
        src = pkgs.fetchFromGitHub {
          owner = "dracula";
          repo = "fish";
          rev = "28db361b55bb49dbfd7a679ebec9140be8c2d593";
          sha256 = "07kz44ln75n4r04wyks1838nhmhr7jqmsc1rh7am7glq9ja9inmx";
        };
      }
    ];
    functions = {
      ls = "exa $argv";
      cat = "bat $argv";
      ex = ''
        if test -f $argv
          switch $argv
            case '*.tab.bz2'
              tar xjf $argv
                case '*.tar.gz'
                  tar xzf $argv
                case '*.bz2'
                  bunzip2 $argv
                case '*.rar'
                  unrar x $argv
                case '*.gz'
                  gunzip $argv
                case '*.tar'
                  tar xvf $argv
                case '*.tbz2'
                  tar xjf $argv
                case '*.tgz'
                  tar xzf $argv
                case '*.zip'
                  unzip $argv
                case '*.Z'
                  uncompress $argv
                case '*.7z'
                  7z x $argv
                case '*'
                  echo "$argv cannot be extracted via ex()"
              end
            else
              echo "$argv is not a valid file!"
            end
      '';
    };
  };
}
