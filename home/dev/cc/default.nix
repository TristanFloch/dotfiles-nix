{ options, config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.dev.cc;
in
{
  options.modules.dev.cc.enable = mkEnableOption "C/C++ dev environment";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gcc
      clang-tools
      gnumake
      cmake
      gdb
      bear
    ];
  };
}
