{
  description = "Tristan's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    systems.url = "github:nix-systems/default";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, systems, ... }@inputs:
    let
      inherit (self) outputs;

      lib = nixpkgs.lib // nix-darwin.lib // home-manager.lib;
      forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs (import systems) (
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
      );
    in {
      # Custom packages acessible through 'nix build', 'nix shell', ...
      packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});

      # Devshell for bootstrapping acessible through 'nix develop' or 'nix-shell' (legacy)
      devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});

      formatter = forEachSystem (pkgs: pkgs.alejandra);

      # Custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs outputs; };

      # Reusable nixos modules to possibly export
      # These are usually stuff to upstream into nixpkgs
      nixosModules = import ./modules/nixos;

      # Reusable home-manager modules to possibly export
      # These are usually stuff to upstream into home-manager
      homeManagerModules = import ./modules/home-manager;

      # NixOS configurations entrypoint
      # Available through 'nixos-rebuild --flake .#configName'
      nixosConfigurations = {
        nixos-zenbook = lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./nixos/nixos-zenbook ];
        };
      };

      # nix-darwin configurations entrypoint
      # Available through 'darwin-rebuild --flake .#configName'
      darwinConfigurations = {
        macbook-pro-m4 = lib.darwinSystem {
          modules = [ ./darwin/macboook-pro-m4 ];
          specialArgs = { inherit self inputs outputs; };
        };
      };

      # Standalone home-manager configurations entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        "tristan@nixos-zenbook" = lib.homeManagerConfiguration {
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home-manager/tristan/nixos-zenbook.nix ];
        };

        "tfloch@alma-dell" = lib.homeManagerConfiguration {
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home-manager/tristan/alma-dell.nix ];
        };

        "tristan@macbook-pro-m4" = lib.homeManagerConfiguration {
          pkgs = pkgsFor.aarch64-darwin;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home-manager/tristan/macbook-pro-m4.nix ];
        };
      };
    };
}
