{
  inputs,
  outputs,
  lib,
  pkgs,
  config,
  ...
}:
let
  flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in
{
  nix = {
    package = pkgs.lixPackageSets.stable.lix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
      substituters = [ "https://nix-community.cachix.org/" ];
      trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
      trusted-users = [
        "root"
        "@wheel"
      ];
      flake-registry = ""; # Disable global flake registry
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };

    # Add each flake input as a registry and nix_path
    registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;

    # GitHub token for API rate limits and private flake inputs,
    # decrypted by sops-nix at activation ('!' = don't fail if absent)
    extraOptions = "!include ${config.sops.templates."nix-access-tokens".path}";
  };

  sops = {
    secrets.github-token = { };
    templates."nix-access-tokens".content =
      "access-tokens = github.com=${config.sops.placeholder.github-token}";
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config.allowUnfree = true;
  };
}
