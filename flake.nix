{
  description = "Plotting the Zeta function";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    with flake-utils.lib; eachSystem allSystems (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfreePredicate = (pkg: true);
          };
        };
      in
      {
        # Nix develop
        devShells.default = pkgs.mkShell {
          name = "octave-dev";
          buildInputs = [
            pkgs.ghostscript
            (pkgs.octaveFull.withPackages (opkgs: with opkgs; [ symbolic ]))
          ];
        };
      });
}
