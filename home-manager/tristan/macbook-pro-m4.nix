{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./global

    ./features/cli
    ./features/fonts
    ./features/vim
    ./features/emacs
    ./features/terminal
  ];

  home = {
    username = "tristan";
    homeDirectory = "/Users/${config.home.username}";
    stateVersion = "24.11";
  };

  programs.git = {
    settings = {
      user.email = "tristan.floch@gmail.com";
      url."git@github.com:".insteadOf = "https://github.com/";
      gpg = {
        format = "ssh";
        ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"; # use ssh-agent from 1password
      };
    };
    signing.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGooRy/CxVJB0qRSgSw5DsGgxtWYvTm5/Ua4rKZvtcXQ";
    lfs.enable = true;
  };

  programs.direnv.config.whitelist.prefix = [
    "${config.home.homeDirectory}/.claude/worktrees"
    "${config.home.homeDirectory}/.codex/worktrees"
  ];
}
