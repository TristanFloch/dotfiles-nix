{ config, lib, pkgs, ... }:

{
  imports = [ ./vim ./emacs ./helix ];

  home.sessionVariables = {
    EDITOR = "vim"; # God forgive me
  };
}
