{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    ./global

    ./features/cli
    ./features/emacs
    ./features/fonts
    ./features/vim
  ];

  home = {
    username = "tfloch";

    packages = with pkgs; [
      python311Packages.python-lsp-server
      yaml-language-server
    ];
  };

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  programs.git.signing.key = null;

  # https://nixos.wiki/wiki/Home_Manager#Usage_on_non-NixOS_Linux
  targets.genericLinux.enable = true;

  # Let HM manage the whole shell session
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      source scl_source enable gcc-toolset-9

      export HISTSIZE=100000     # big history
      export HISTFILESIZE=100000 # big history
      export HISTCONTROL=ignoreboth:erasedups # remove duplicates

      # CUDA
      export PATH=/usr/local/cuda/bin/:/usr/local/cuda-12.2/bin:$HOME/.local/bin:$PATH

      export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/lib/pkgconfig/:/usr/local/lib64/pkgconfig/:/usr/local/lib/pkgconfig/

      export LD_LIBRARY_PATH=/usr/local/lib64/
      export GST_PLUGIN_PATH=/usr/local/lib64/

      folder(){
      sudo mkdir -p $1; sudo chown $USER $1
      }

      multifolder(){
      folder /var/run/dzmultiflux
      folder /var/run/dzmultiview/acquisition
      folder /var/spool/dzmultiview/acquisition
      folder /var/run/dzmultipark
      folder /var/run/dzwallaggregator
      folder /var/lib/dzcrowdupdater
      folder /var/run/dzbenchmark
      folder /var/run/dzscreenaggregator
      folder /var/spool/dzscreenaggregator/reports
      folder /var/spool/dzscreenaggregator/saved_events
      folder /var/spool/dzmultiflux/detection_dumper
      }

      multifolder 2> /dev/null
    '';
  };

}
