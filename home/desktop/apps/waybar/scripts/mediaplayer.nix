{ config, lib, pkgs, ... }:

with pkgs.python3Packages;

buildPythonApplication {
  pname = "waybar-mediaplayer";
  version = "1.0";

  nativeBuildInputs = with pkgs; [
    wrapGAppsHook
    gobject-introspection
  ];

  propagatedBuildInputs = with pkgs; [
    playerctl
    glib
    python3
    python39Packages.setuptoolsBuildHook
    python39Packages.pygobject3
    python39Packages.pip
  ];
  strictDeps = false;

  src = ./mediaplayer;
}
