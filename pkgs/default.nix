{ pkgs ? null }:

{
  hey = pkgs.callPackage ./hey { };
  mediaplayer-monitor = pkgs.callPackage ./mediaplayer { };
}
