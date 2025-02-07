{
  description = "A very basic flake";

  inputs = {
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    inherit (self) outputs;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    overlays = import ./overlays { inherit inputs; };
    
    nixosConfigurations.GA403UI = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs; inherit outputs;};
      modules = [
        ./hosts/GA403UI/configuration.nix
      ];
    };
  };
}
