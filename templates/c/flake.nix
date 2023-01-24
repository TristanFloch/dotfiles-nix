{
  description = "Development environment for C programming";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05"; };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [ gcc gnumake clang-tools gdb bear ];
        shellHook = ''
          ${pkgs.fish}/bin/fish && exit
        '';
      };
    };
}
