{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    python3Full
    python311Packages.python-lsp-server
  ];

  shellHook = "fish";
}
