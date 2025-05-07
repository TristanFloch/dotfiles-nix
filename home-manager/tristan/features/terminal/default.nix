{ config, lib, pkgs, ... }:

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
      theme = "dark:DoomOne,light:ayu_light";
      font-size = 16;
      font-family = "SauceCodePro Nerd Font";
      background-opacity = 0.95;
      background-blur = true;
      shell-integration = "fish";
      shell-integration-features = true;
      macos-option-as-alt = true;
      auto-update = "check";
    };
  };
}
