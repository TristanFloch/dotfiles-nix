{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = false;
    settings = {
      add_newline = true;
      line_break.disabled = true;
      character = {
        success_symbol = "👉"; # 🚀
        error_symbol = "💥";
        vicmd_symbol = "🖌️";
        vimcmd_replace_symbol = "🔧";
        vimcmd_replace_one_symbol = "🔧";
        vimcmd_visual_symbol = "🥽";
      };
      directory.home_symbol = " ⛺";
      gcloud.disabled = true;
      git_branch.truncation_length = 20;

      # nix_shell = {
      #   format = "via [$symbol( $name)$state]($style) ";
      #   impure_msg = " ";
      #   pure_msg = "";
      #   symbol = "❄ ";
      # };
      # username = {
      #   format = "[$user]($style) on ";
      #   style_user = "bold #bd93f9";
      # };
    };
  };
}
