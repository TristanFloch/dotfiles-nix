{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    gcc
    clang-tools
    gnumake
    cmake
    gdb
    bear
  ];

  shellHook = "fish";
}
