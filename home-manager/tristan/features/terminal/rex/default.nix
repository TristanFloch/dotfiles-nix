{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Rex prepends its bin dir to PATH, but Nix shell init resets PATH afterwards.
  # https://www.superlogical.com/rex/docs/automate/cli#path
  programs.fish.interactiveShellInit = lib.mkAfter ''
    if set -q REX_BIN_DIR
      fish_add_path --path --prepend --move $REX_BIN_DIR
    end
  '';

  # Apply changes with `rex config reload` after switching.
  # https://www.superlogical.com/rex/docs/customize/config
  xdg.configFile."rex/init.lua".source = ./init.lua;
}
