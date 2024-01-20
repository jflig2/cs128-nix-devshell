{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
    default-systems.url = "github:nix-systems/default";
  };

  outputs = inputs @ { self, nixpkgs, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = (import inputs.default-systems);
      perSystem = { pkgs, system, ... }: {
        devShells.default = pkgs.mkShell {
          name = "cs128";
          packages = with pkgs; [
            lld_16
            llvmPackages_16.clang
            gnumake
          ];
        };
      };
    };
}
