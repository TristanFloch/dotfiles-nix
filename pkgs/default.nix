{ pkgs ? null }:

{
  hey = pkgs.callPackage ./hey { };
}
