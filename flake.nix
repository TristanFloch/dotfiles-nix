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
  };

  outputs = inputs@{ self, ... }:
    let
      system = "x86_64-linux";
      modules = builtins.attrValues self.nixosModules;
      unstable-overlay = final: prev: {
        unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
      };
      waybar-overlay = final: prev: {
        waybar = prev.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        });
      };
      hyprland-overlay = inputs.hyprland.overlays.default;
      emacs-overlay = inputs.emacs-overlay.overlay;

      overlays = [
        emacs-overlay
        unstable-overlay
        hyprland-overlay
        waybar-overlay
      ];
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
        nixos-zenbook = inputs.nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            inputs.home-manager.nixosModule
            inputs.hyprland.nixosModules.default

            ./hosts/nixos-zenbook

            { nixpkgs.overlays = overlays; }
          ] ++ modules;
        };
      };
    };
}
