{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf;
  cfg = config.modules.desktop.sessions.wayland;
in
{
  config = mkIf cfg.enable {
    environment.loginShellInit = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec sway
      fi
    '';
  };
}
