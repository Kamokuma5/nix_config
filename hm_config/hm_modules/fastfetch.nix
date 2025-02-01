{ config, pkgs, lib, ... }:

{
  home.file = {
    ".config/fastfetch/config.jsonc" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/duck/nix_config/hm_config/dots/fastfetch/config.jsonc";
    };
    ".config/fastfetch/space_surf.jpg" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/duck/nix_config/hm_config/dots/fastfetch/space_surf.jpg";
    };
  };
}