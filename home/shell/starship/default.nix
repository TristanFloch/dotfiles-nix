{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    settings = {
      add_newline = true;
      line_break.disabled = true;

      nix_shell = {
        format = "via [$symbol( $name)$state]($style) ";
        impure_msg = " ";
        pure_msg = "";
        symbol = "❄ ";
      };

      git_branch.truncation_length = 20;

      # Dracula theme
      aws.style = "bold #ffb86c";
      cmd_duration.style = "bold #f1fa8c";
      directory.style = "bold #50fa7b";
      hostname.style = "bold #ff5555";
      git_branch.style = "bold #ff79c6";
      git_status.style = "bold #ff5555";
      username = {
        format = "[$user]($style) on ";
        style_user = "bold #bd93f9";
      };
      character = {
        success_symbol = "👉";# 🚀
        error_symbol = "💥";
      };
      directory = {
        home_symbol = " ⛺";
      };
    };
  };
}
