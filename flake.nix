{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      overlays = [ inputs.emacs-overlay.overlay ];
      modules = builtins.attrValues self.nixosModules;
    in {
      nixosModules = {
        modules = import ./modules;

        home.home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.tristan = import ./home;
        };
      };

      nixosConfigurations = {
        nixos-zenbook = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            home-manager.nixosModule

            ./hosts/nixos-zenbook

            { nixpkgs.overlays = overlays; }
          ] ++ modules;
        };
      };
    };
}
