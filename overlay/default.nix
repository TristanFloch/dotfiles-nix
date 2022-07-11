{ inputs, system, ... }: final: prev: {
  unstable = inputs.nixpkgs-unstable.legacyPackages.${system};

  waybar = prev.waybar.overrideAttrs (oldAttrs: {
    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  });

  # Temporary fix for https://github.com/emersion/xdg-desktop-portal-wlr/issues/216
  xdg-desktop-portal-wlr-hyprland = prev.xdg-desktop-portal-wlr.overrideAttrs (oldAttrs: rec {
    pname = "xdg-desktop-portal-wlr";
    version = "0.5.0";
    src = prev.fetchFromGitHub {
      owner = "emersion";
      repo = pname;
      rev = "v${version}";
      sha256 = "sha256-weePlNcLmZ3R0IDQ95p0wQvsKTYp+sVlTENJtF8Z78Y";
    };
  });
}
