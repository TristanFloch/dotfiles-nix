{ pkgs, ... }:

# TODO function to refactor this
{
  cc = import ./cc { inherit pkgs; };
  python = import ./python { inherit pkgs; };
  tex = import ./tex { inherit pkgs; };
  rust = import ./rust { inherit pkgs; };
}
