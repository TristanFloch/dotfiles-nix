{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";

    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs = { home-manager, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      overlays = [
        inputs.emacs-overlay.overlay
      ];
    in
    {
      nixosConfigurations = {
        nixos-zenbook = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix

            { nixpkgs.overlays = overlays; }

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.tristan = import ./home.nix;
                # Optionally, use home-manager.extraSpecialArgs to pass
                # arguments to home.nix
              };
            }
          ];
        };
      };
    };
}
