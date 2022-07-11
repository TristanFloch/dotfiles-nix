{ inputs, system, ... }: final: prev: {
  unstable = inputs.nixpkgs-unstable.legacyPackages.${system};

  waybar = prev.waybar.overrideAttrs (oldAttrs: {
    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  });
}
