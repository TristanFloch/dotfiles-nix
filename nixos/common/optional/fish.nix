{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    vendor = {
      completions.enable = true;
      config.enable = true;
      functions.enable = true;
    };
  };

  # TODO make this user generic
  users.users.tristan.shell = pkgs.fish;
}
