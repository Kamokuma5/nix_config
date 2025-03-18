{
  description = "A very basic flake";

  inputs = {
    hyprland.url = "github:hyprwm/Hyprland";

    # TODO: Temporary fix for Mesa drivers
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs_unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs_unstable.url = "github:r-ryantm/nixpkgs/auto-update/driversi686Linux.amdvlk";
  };

  outputs = { self, nixpkgs, nixpkgs_unstable, chaotic, ... }@inputs:
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
    nixosConfigurations.fishtank = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
        inherit outputs;
        pkgs_unstable = import nixpkgs_unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
      modules = [
        ./hosts/fishtank/configuration.nix
      ];
    };
  };
}
