{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    ./global

    ./features/cli
  ];

  home = {
    username = "tfloch";

    packages = with pkgs; [
      bitwarden
      spotify
    ];
  };

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  programs.git.signing.key = null;
}
