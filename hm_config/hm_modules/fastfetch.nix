{ config, pkgs, lib, ... }:

{
  home.file = {
    ".config/fastfetch/config.jsonc" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/duck/nix_config/hm_config/dots/fastfetch/config.jsonc";
    };
    ".config/fastfetch/ascii.txt" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/duck/nix_config/hm_config/dots/fastfetch/ascii.txt";
    };
  };
}