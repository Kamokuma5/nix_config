{
  description = "A very basic flake";

  inputs = {
    hyprland.url = "github:hyprwm/Hyprland";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs_unstable.url = "github:nixos/nixpkgs/master";
  };

  outputs = { self, nixpkgs, nixpkgs_unstable, ... }@inputs:
  let
    inherit (self) outputs;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {    
    nixosConfigurations.GA403UI = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
        inherit outputs;
        pkgs_unstable = import nixpkgs_unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
      modules = [
        ./hosts/GA403UI/configuration.nix
      ];
    };
  };
}
