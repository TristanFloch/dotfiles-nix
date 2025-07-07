{ config, pkgs, ... }:

let
  themes = {
    catppuccin = {
      name = "catppuccin";
      src = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "fish";
        rev = "0fd0c48a844636c6082f633cc4f2800abb4b6413";
        sha256 = "0q0vp6a8s42a2pwyp9d12bnl5gwyij0m8p22xc60x7bl8c3gbdhq";
      };
    };
  };
in # builtins.attrValues themes # .${config.modules.theme.name}
   # ++ 
[
  {
    # FIXME
    name = "done";
    src = pkgs.fishPlugins.done;
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
  # {
  #   name = "fish-async-prompt";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "acomagu";
  #     repo = "fish-async-prompt";
  #     rev = "40f30a4048b81f03fa871942dcb1671ea0fe7a53";
  #     sha256 = "19i59145lsjmidqlgk2dmvs3vg2m3zlz2rcms2kyyk1m3y63q8xi";
  #   };
  # }
  {
    name = "replay";
    src = pkgs.fetchFromGitHub {
      owner = "jorgebucaran";
      repo = "replay.fish";
      rev = "d2ecacd3fe7126e822ce8918389f3ad93b14c86c";
      sha256 = "1n2xji4w5k1iyjsvnwb272wx0qh5jfklihqfz0h1a1bd3zp3sd2g";
    };
  }
]
