{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, ... }:
    let
      inherit (builtins) attrValues mapAttrs;
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs { inherit system; };
    in rec {
      overlays = {
        default = import ./overlay {
          inherit inputs;
          inherit system;
        };

        hyprland = inputs.hyprland.overlays.default;
        emacs = inputs.emacs-overlay.overlay;
      };

      nixosModules = {
        modules = import ./modules;

        home.home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.tristan = import ./home;
          extraSpecialArgs = { inherit inputs; };
        };
      };

      nixosConfigurations = {
        nixos-zenbook = inputs.nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            inputs.home-manager.nixosModule
            inputs.hyprland.nixosModules.default

            ./hosts/nixos-zenbook

            { nixpkgs.overlays = attrValues overlays; }
          ] ++ attrValues nixosModules;

          specialArgs = { inherit inputs; };
        };
      };

      devShells.${system} = import ./home/dev { inherit pkgs; };
    };
}
