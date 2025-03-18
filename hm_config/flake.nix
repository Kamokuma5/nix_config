{
  description = "A very basic flake";

  inputs = {
    # Not in repo. If you make change to this repo, it might not make it to the nix store.
    # nix_secrets = {
    #  url = "git+ssh://git@github.com/kamokuma5/nix_secrets?ref=main";
    # };

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprpanel, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    homeConfigurations = {
      "duck" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            inputs.hyprpanel.overlay
          ];
          config.allowUnfree = true;
        };
        
        extraSpecialArgs = {
          inherit system;
          inherit inputs;
        };
  
        modules = [ 
          ./home_duck.nix
        ];
      };
      "bear" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            inputs.hyprpanel.overlay
          ];
          config.allowUnfree = true;
        };
        
        extraSpecialArgs = {
          inherit system;
          inherit inputs;
        };

        modules = [
          ./home_bear.nix
        ];
      };
    };
  };
}
