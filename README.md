# arouteserver.nix

Nix derivation for [arouteserver](https://github.com/pierky/arouteserver).

## Usage

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    arouteserver = {
      url = "github:dd-ix/arouteserver.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, arouteserver, ... }: {
    nixosConfigurations = {
      hostname = nixpkgs.lib.nixosSystem {
        modules = [
          arouteserver.nixosModules.default
          { nixpkgs.overlays = [ arouteserver.overlays.default ]; }
        ];
      };
    };
  };
}
```
