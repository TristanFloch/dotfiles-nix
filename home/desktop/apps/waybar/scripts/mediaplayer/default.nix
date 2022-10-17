{ config, lib, pkgs, ... }:

with pkgs.python3Packages;

buildPythonApplication {
  pname = "waybar-mediaplayer";
  version = "1.0";

  nativeBuildInputs = with pkgs; [ wrapGAppsHook gobject-introspection ];

  propagatedBuildInputs = with pkgs; [
    playerctl
    glib
    python3
    python310Packages.setuptoolsBuildHook
    python310Packages.pygobject3
    python310Packages.pip
  ];
  strictDeps = false;

  src = ./.;
}
