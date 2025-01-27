# Duck's Nix Config

## Overview
This repo contains 2 flakes for both NixOS and home-manager configs respectively. It expects the repo to be cloned in `~/`.

## How to build NixOS
`sudo nixos-rebuild switch --flake ~/nix_config/nixos_config#GA403UI --impure`

## How to build home-manager
`home-manager switch --flake ~/nix_config/hm_config/#duck --refresh --impure`

## How to update
```
cd hm_config/
nix flake update
cd ../nixos_config
nix flake update
```

## How to clean Nix
1. `sudo nix-env --list-generations --profile /nix/var/nix/profiles/system`
    
2. `sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations 11 12`

3. `nix-collect-garbage`