{ options, config, lib, pkgs, ... }:

{
  imports = [ ./docker ];

  services.gvfs.enable = true;
}
