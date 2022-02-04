{ pkgs, ... }:
[
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
]
