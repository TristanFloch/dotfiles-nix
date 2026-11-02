{
  config,
  lib,
  pkgs,
  ...
}:

let
  rexLuaTypes = pkgs.writers.writePython3Bin "rex-lua-types" { } (
    builtins.readFile ./rex-lua-types.py
  );
in
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

  # LSP types for the running app's actions, read through ./.luarc.json.
  # Only a running app can list them; run `rex-lua-types` after a Rex update.
  home = {
    packages = [ rexLuaTypes ];
    activation.rexLuaTypes = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      run ${lib.getExe rexLuaTypes}
    '';
  };
}
