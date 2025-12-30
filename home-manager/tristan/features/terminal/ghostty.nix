{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.ghostty = {
    enable = true;
    package = lib.mkIf pkgs.stdenv.isDarwin null;
    enableFishIntegration = true;
    # enableBashIntegration = true;
    # enableZshIntegration = true;
    installBatSyntax = false;
    # installVimSyntax = true;
    settings = {
      theme = "dark:Doom One,light:Ayu Light";
      font-family = "Iosevka Nerd Font Mono";
      font-size = 17;
      background-opacity = 0.95;
      background-blur = true;
      shell-integration = "fish";
      shell-integration-features = true;
      macos-option-as-alt = true;
      auto-update = "check";
      keybind = [
        "shift+enter=text:\\x1b\\r" # for Claude Code
      ];
    };
  };
}
