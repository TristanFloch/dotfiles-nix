{ options, config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.dev.python;

  my-python-packages = python-packages: with python-packages; [
    dbus-python
  ];
  python-with-my-packages = pkgs.python3.withPackages my-python-packages;
in
{
  options.modules.dev.python.enable = mkEnableOption "Python dev environment";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      python-with-my-packages
      python-language-server
    ];
  };
}
