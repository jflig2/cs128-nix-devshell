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
          hardeningDisable = [ "all" ];
          packages = with pkgs; [
            bear
            clang-tools_16
            clang_16
            gnumake
            lld_16
          ];
        };
      };
    };
}
