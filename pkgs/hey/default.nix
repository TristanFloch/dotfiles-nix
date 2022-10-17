# This program is inspired by the great @hlissner.
# See https://github.com/hlissner/dotfiles/blob/master/bin/hey

{ lib, python3Packages }:

with python3Packages;

buildPythonApplication {
  pname = "hey";
  version = "1.0";

  buildInputs = [ setuptools termcolor ];

  src = ./.;
}
