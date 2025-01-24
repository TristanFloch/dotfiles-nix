{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./global

    ./features/linux
    ./features/cli
    ./features/emacs
    ./features/fonts
    ./features/vim
  ];

  home = {
    username = "tfloch";

    packages = with pkgs; [ python311Packages.python-lsp-server ];
  };

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  programs.git = {
    userEmail = "tristan.floch@digeiz.com";
    signing.key = "AF3C4AB42C2B9F60FEB065CB093E9E23AA565662";
    extraConfig = {
      tag.forceSignAnnotated = true;
      core.symlinks = true;
    };
  };

  # https://nixos.wiki/wiki/Home_Manager#Usage_on_non-NixOS_Linux
  targets.genericLinux.enable = true;

  # Let HM manage the whole shell session
  programs.bash = {
    enable = true;
    # enableCompletion = true;
    enableVteIntegration = true;
    profileExtra = ''
      source scl_source enable gcc-toolset-12

      export BOOST_INCLUDEDIR=/usr/include/boost169
      export BOOST_LIBRARYDIR=/usr/lib64/boost169

      # CUDA
      export PATH=/usr/local/cuda/bin/:/usr/local/cuda-12.2/bin:$HOME/.local/bin:$PATH

      export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/lib/pkgconfig/:/usr/local/lib64/pkgconfig/:/usr/local/lib/pkgconfig/

      export LD_LIBRARY_PATH=/usr/local/lib64/
      export GST_PLUGIN_PATH=/usr/local/lib64/
    '';

    bashrcExtra = ''
      export HISTSIZE=100000     # big history
      export HISTFILESIZE=100000 # big history
      export HISTCONTROL=ignoreboth:erasedups # remove duplicates

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

      export DZ_USERNAME=VAULT_USERNAME
      export DZ_PASSWORD=VAULT_PASSWORD
      export DZ_VAULT_SECRET_ID=980ef93d-335a-2ed3-9583-2ae2b456d76c
    '';
  };

  programs.fish.functions = {
    mall_ids = ''
      cat  ~/Documents/configurations/malls_config.json | jq -r '.malls[] | "\(.mall_folder) \(.id)\t\(.ip_address)"' | column -t
    '';
  };
}
