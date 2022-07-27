{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.editors.helix;
in {
  options.modules.editors.helix.enable = mkEnableOption "Helix text editor";

  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;
      settings = {
        theme = "dracula";
        editor = {
          line-number = "relative";
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
          lsp.display-messages = true;
        };

        keys = let global_keymaps = { "A-x" = "command_palette"; };
        in {
          normal = {
            space = {
              space = "file_picker";
              b = {
                b = "buffer_picker";
                k = ":q!";
                K = ":buffer-close-all!";
                O = ":buffer-close-others!";
                s = ":w";
              };
              h = {
                k = "hover";
                # r = ":config_reload";
              };
              s = {
                s = "symbol_picker";
                p = "workspace_symbol_picker";
                # P = "global_seach";
              };
              c = {
                a = "code_action";
                r = "rename_symbol";
                # f = "format_selection";
              };
            };
          } // global_keymaps;
          insert = { } // global_keymaps;
          select = { } // global_keymaps;
        };
      };
    };
  };
}
