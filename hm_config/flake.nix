{
  description = "A very basic flake";

  inputs = {
     nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
#     pkgs = nixpkgs.legacyPackages.${system};
    pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
  in {
    homeConfigurations = {
      "duck" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };
    };
  };
}
