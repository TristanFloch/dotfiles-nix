{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    ./global

    ./features/cli
    ./features/emacs
    ./features/fonts
    ./features/vim
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

  # https://nixos.wiki/wiki/Home_Manager#Usage_on_non-NixOS_Linux
  targets.genericLinux.enable = true;

  # Let HM manage the whole shell session
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };
}
