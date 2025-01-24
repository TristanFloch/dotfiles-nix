{ pkgs, inputs, outputs, ... }:

{
  imports = [
    inputs.home-manager.darwinModules.home-manager

    ./nix.nix
  ];

  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs outputs; };
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    vim
    wget
  ];
}
