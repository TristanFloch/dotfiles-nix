{ config, lib, pkgs, ... }:

let
  dracula-icons = pkgs.stdenv.mkDerivation {
    pname = "dracula-icons";
    version = "1.0";

    src = pkgs.fetchzip {
      url = "https://github.com/dracula/gtk/files/5214870/Dracula.zip";
      sha256 = "sha256-rcSKlgI3bxdh4INdebijKElqbmAfTwO+oEt6M2D1ls0=";
    };

    propagatedUserEnvPkgs = with pkgs; [
      gtk-engine-murrine
    ];

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/icons/Dracula
      mv * $out/share/icons/Dracula

      runHook postInstall
    '';
  };

  dracula-icons-bis = pkgs.stdenv.mkDerivation rec {
    pname = "dracula-icons";
    version = "1.0";

    src = pkgs.fetchFromGitHub {
      owner = "m4thewz";
      repo = pname;
      rev = "2d3c83caa8664e93d956cfa67a0f21418b5cdad8";
      sha256 = "sha256-GY+XxTM22jyNq8kaB81zNfHRhfXujArFcyzDa8kjxCQ=";
    };

    dontPatchELF = true;
    dontRewriteSymlinks = true;

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/icons/Dracula
      mv * $out/share/icons/Dracula

      runHook postInstall
    '';
  };
in
{
  gtk = {
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };

    iconTheme = {
      name = "Dracula";
      package = dracula-icons-bis;

      # name = "Tela-purple-dark";
      # package = pkgs.tela-icon-theme;
    };

    font = {
      name = "Ubuntu";
      size = 11;
    };
  };
}
