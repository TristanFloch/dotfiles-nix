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
        };
      };

      nixosConfigurations = {
        nixos-zenbook = inputs.nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            inputs.home-manager.nixosModule
            inputs.hyprland.nixosModules.default

            ./hosts/nixos-zenbook

            {
              nixpkgs.overlays = attrValues overlays;
              environment.etc = {
                "nix/channels/nixpkgs".source = inputs.nixpkgs.outPath;
                "nix/channels/home-manager".source = inputs.home-manager.outPath;
              };
              nix = {
                registry = mapAttrs (_: value: { flake = value; }) inputs;
                nixPath = [
                  "nixpkgs=/etc/nix/channels/nixpkgs"
                  "home-manager=/etc/nix/channels/home-manager"
                ];
              };
            }
          ] ++ attrValues nixosModules;
        };
      };

      devShells.${system} = import ./home/dev { inherit pkgs; };
    };
}
