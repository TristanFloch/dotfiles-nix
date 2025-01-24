{ pkgs, inputs, outputs, ... }:

{
  imports = [
    inputs.home-manager.darwinModules.home-manager
    inputs.mac-app-util.darwinModules.default

    ./nix.nix
  ];

  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs outputs; };
  };

  environment = {
    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    systemPackages = with pkgs; [
      vim
      wget
    ];

    variables = {
      LANG = "en_US.UTF-8";
    };
  };
}
