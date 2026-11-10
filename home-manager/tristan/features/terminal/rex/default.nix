{
  config,
  lib,
  pkgs,
  ...
}:

let
  # Location of $REX_BIN_DIR, which is set by Rex on macOS.
  rexBinDir = "${config.home.homeDirectory}/Library/Application Support/com.superlogical.rex/RexServer/Versions/Current/Rex Server.app/Contents/MacOS";
  rexLuaTypes = pkgs.writers.writePython3Bin "rex-lua-types" { } (
    builtins.readFile ./rex-lua-types.py
  );
in
{
  # Apply changes with `rex config reload` after switching.
  # https://www.superlogical.com/rex/docs/customize/config
  xdg.configFile."rex/init.lua".source = ./init.lua;

  # LSP types for the running app's actions, read through ./.luarc.json.
  # Only a running app can list them; run `rex-lua-types` after a Rex update.
  home = {
    packages = [ rexLuaTypes ];
    # The activation script sets its own PATH, which sessionPath doesn't reach.
    activation.rexLuaTypes = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      run env PATH=${lib.escapeShellArg rexBinDir}:"$PATH" ${lib.getExe rexLuaTypes}
    '';
    sessionPath = [ rexBinDir ];
  };

  # Alternative of the sessionPath above, the shell hook as suggested in https://www.superlogical.com/rex/docs/automate/cli#path:
  # programs.fish.interactiveShellInit = lib.mkAfter ''
  #   if set -q REX_BIN_DIR
  #     fish_add_path --path --prepend --move $REX_BIN_DIR
  #   end
  # '';
}
