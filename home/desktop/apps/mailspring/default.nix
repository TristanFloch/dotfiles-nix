{ options, config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.desktop.apps.mailspring;
in {
  options.modules.desktop.apps.mailspring.enable = mkEnableOption "mailspring";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ mailspring ];

    home.file.".config/Mailspring/themes/dracula".source =
      pkgs.fetchFromGitHub {
        owner = "dracula";
        repo = "mailspring";
        rev = "6ed9936e744c074454cf27be256674c422e1d1a3";
        sha256 = "sha256-xOCm3+TxS2x0maZF+fykYiCXEGxPxNwUjaHVrQ90Paw=";
      };

    services.gnome-keyring.enable = true;
  };
}
