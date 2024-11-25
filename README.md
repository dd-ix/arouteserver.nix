# arouteserver.nix

---

Arouteserver got upstreamed to nixpkgs in <https://github.com/NixOS/nixpkgs/pull/353218>.
See <https://search.nixos.org/packages?channel=24.11&from=0&size=50&sort=relevance&type=packages&query=arouteserver>.

---

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
