# nix copy --from file:///tmp/nix-cache .#devShells.x86_64-linux.default
# nix develop --offline
{
  description = "Flake для Node.js + TypeScript разработки (offline-ready)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.nodejs_22
            pkgs.nodePackages.npm
            pkgs.nodePackages.yarn
            pkgs.nodePackages.typescript   # tsc
            pkgs.nodePackages.ts-node      # запуск TS напрямую
            pkgs.git
          ];

          shellHook = ''
            echo "🚀 Node.js + TypeScript окружение готово!"
            node -v
            npm -v
            tsc -v
          '';
        };
      }
    );
}

