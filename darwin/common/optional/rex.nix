{ ... }:
{
  # Rex prepends its bin dir to PATH, but nix-darwin resets PATH in every shell.
  # Needed for bash/zsh, e.g. agents' shells; fish is handled in home-manager.
  # https://www.superlogical.com/rex/docs/automate/cli#nix
  environment.interactiveShellInit = ''
    if [ -n "$REX_BIN_DIR" ]; then
      export PATH="$REX_BIN_DIR:$PATH"
    fi
  '';

  # Same as Ghostty's macos-option-as-alt (Settings → Terminal → Option key)
  system.defaults.CustomUserPreferences."com.superlogical.rex" = {
    "Workspace.terminalOptionKeyBehavior" = "leftActsAsAlt";
  };
}
