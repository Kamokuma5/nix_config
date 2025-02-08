{
  description = "A very basic flake";

  inputs = {
    hyprland.url = "github:hyprwm/Hyprland";
    nixpkgs-bleeding-edge.url = "github:merrkry/nixpkgs/rog-control-center-fix";
  };

  outputs = { self, nixpkgs, nixpkgs-bleeding-edge, ... }@inputs:
  let
    inherit (self) outputs;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    # overlays = import ./overlays { inherit inputs; };
    
    nixosConfigurations.GA403UI = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
        inherit outputs;
        pkgs-bleeding-edge = import nixpkgs-bleeding-edge {
          # Refer to the `system` parameter from
          # the outer scope recursively
          inherit system;
          # To use Chrome, we need to allow the
          # installation of non-free software.
          config.allowUnfree = true;
        };
      };
      modules = [
        ./hosts/GA403UI/configuration.nix
      ];
    };
  };
}
