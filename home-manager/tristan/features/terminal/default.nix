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
    enableBashIntegration = true;
    enableZshIntegration = true;
    installBatSyntax = false;
    # installVimSyntax = true;
    settings = {
      theme = "dark:DoomOne,light:AtomOneLight";
      font-size = 16;
      font-family = "SauceCodePro Nerd Font";
    };
  };
}
