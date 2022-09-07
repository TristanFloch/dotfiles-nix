{ options, config, lib, pkgs, ... }:

let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.modules.services.docker;
in {
  options.modules.services.docker.enable = mkEnableOption "Docker";

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;

    environment.systemPackages = with pkgs; [ docker ];
  };
}
