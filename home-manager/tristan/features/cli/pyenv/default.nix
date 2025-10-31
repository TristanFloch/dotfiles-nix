{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.pyenv = {
    enable = true;
    enableFishIntegration = true;
  };
}
