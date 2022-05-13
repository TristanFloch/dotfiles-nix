inputs@{ self, home-manager, nixpkgs, system, ... }:

{
  config = hostName:
    nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./hosts/configuration.nix
        ./hosts/nixos-zenbook/hardware-configuration.nix

        { networking.hostName = "nixos-zenbook"; }

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.tristan = import ./hosts/home.nix;
          };
        }
      ];
    };
}
