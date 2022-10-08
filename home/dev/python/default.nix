{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    python3Full
    python-language-server
  ];

  shellHook = "fish";
}
