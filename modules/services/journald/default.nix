{ config, lib, pkgs, ... }:

{
  # logging config for journalctl
  # log levels are: emerg - alert - crit - err - warning - notice - info - debug
  # nothing is configured to be redirected to syslog and console so they should
  # be useless.
  #
  # storage=volatile means to store journal data in memory and not on disk
  # it prevents flushing the data to the disk and thus save boot time
  services.journald.extraConfig = ''
    Storage=volatile
    SystemMaxUse=100M
    MaxLevelWall=emerg # default=emerg
    MaxLevelKMsg=notice # default=notice
    MaxLevelStore=warning # default=debug
    MaxLevelConsole=warning # default=info
    MaxLevelSyslog=notice # default=debug
  '';
}
