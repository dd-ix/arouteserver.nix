{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = (import nixpkgs) {
            inherit system;
          };
        in
        {
          packages = rec {
            arouteserver = pkgs.callPackage ./derivation.nix { };
            default = arouteserver;
          };
        }
      ) // {
      overlays.default = _: prev: {
        arouteserver = self.packages."${prev.system}".arouteserver;
      };
    };
}
