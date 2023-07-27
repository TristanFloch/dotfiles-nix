{ config, lib, ... }:

{
  programs.git = {
    enable = true;
    userName = "Tristan Floch";
    userEmail = lib.mkDefault "tristan.floch@gmail.com";
    signing = {
      signByDefault = !builtins.isNull config.programs.git.signing.key;
    };
    ignores = [ "*~" "*.swp" "~" ".direnv/" ".cache/" ];
  };
}
