{
  config,
  lib,
  pkgs,
  ...
}:

let
  # https://github.com/nix-community/home-manager/issues/6295
  ghostty-mock = pkgs.writeShellScriptBin "gostty-mock" ''
    true
  '';
in
{
  programs.ghostty = {
    enable = true;
    package = ghostty-mock;
    enableFishIntegration = true;
    # enableBashIntegration = true;
    # enableZshIntegration = true;
    installBatSyntax = false;
    # installVimSyntax = true;
    settings = {
      theme = "dark:Doom One,light:Ayu Light";
      font-size = 20;
      font-family = "InconsolataGo Nerd Font Mono";
      background-opacity = 0.95;
      background-blur = true;
      shell-integration = "fish";
      shell-integration-features = true;
      macos-option-as-alt = true;
      auto-update = "check";
      keybind = [
        "shift+enter=text:\\x1b\\r"
      ];
    };
  };
}
