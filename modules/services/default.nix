{ options, config, lib, pkgs, ... }:

{
  imports = [ ./docker ./journald ];

  services.gvfs.enable = true;
}
