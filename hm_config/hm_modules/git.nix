{ config, pkgs, lib, ... }:

{
  home.file = {
    ".config/git/config" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/duck/nix_config/hm_config/dots/.gitconfig";
    };
  };
}
