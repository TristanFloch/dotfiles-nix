{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

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
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    hlissner-config = { # god of Doom Emacs
      url = "github:hlissner/dotfiles";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-unstable.follows = "nixpkgs-unstable";
        home-manager.follows = "home-manager";
        emacs-overlay.follows = "emacs-overlay";
      };
    };
  };

  outputs = inputs@{ self, ... }:
    let
      inherit (builtins) attrValues;
      system = "x86_64-linux";
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
        };
      };

      apps."${system}" = rec {
        default = hey;
        hey = inputs.hlissner-config.defaultApp."${system}";
      };
    };
}
