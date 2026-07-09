{ config, lib, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Tristan Floch";
        email = lib.mkDefault "tristan.floch@gmail.com";
      };
      pull = {
        rebase = true;
        updateRefs = true;
      };
      push.autoSetupRemote = true;
      github.user = "TristanFloch";
    };
    signing = {
      signByDefault = !builtins.isNull config.programs.git.signing.key;
    };
    ignores = [
      "*~"
      "*.swp"
      "~"
      ".direnv/"
      ".cache/"
    ];
  };
}
