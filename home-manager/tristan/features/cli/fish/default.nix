{ config, lib, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
      fish_add_path ~/.config/emacs-doom/bin/
    '' + lib.optionalString pkgs.stdenv.isDarwin ''
      fish_add_path /opt/homebrew/bin/
    '';

    shellAbbrs = { } // import ./gitAbbrs.nix;

    shellAliases = {
      # nix-shell = "nix-shell --run fish";
    };

    plugins = import ./plugins.nix {
      inherit config;
      inherit pkgs;
    };

    functions = let
      batmanEnabled = config.programs.bat.enable
        && builtins.elem pkgs.bat-extras.batman
        config.programs.bat.extraPackages;
    in {
      ls = "${pkgs.eza}/bin/eza $argv";
      lls = "${pkgs.coreutils}/bin/ls -f $argv"; # fast ls
      cat = "${pkgs.bat}/bin/bat $argv";
      ccat = "${pkgs.coreutils}/bin/cat $argv";
      tree = "${pkgs.eza}/bin/eza --tree $argv";
      ttree = "${pkgs.tree}/bin/tree $argv";
      ex = {
        body = builtins.readFile ./functions/ex.fish;
        description = "extracts any archive format";
      };
      # monitor = {
      #   body = builtins.readFile ./functions/monitor.fish;
      #   description = "connects/disconnects pluged/unpluged monitors";
      # };
      fish_user_key_bindings = {
        body = ''
          fish_default_key_bindings -M insert
          fish_vi_key_bindings --no-erase insert
        '';
      };
    } // lib.optionalAttrs batmanEnabled {
      man = "${pkgs.bat-extras.batman}/bin/batman $argv";
    };
  };

  # programs.nix-index = {
  #   enable = true;
  #   enableFishIntegration = true;
  # };
}
