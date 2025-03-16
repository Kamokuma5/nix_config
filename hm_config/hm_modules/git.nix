{ config, pkgs, lib, ... }:

{
  home.file = {
    ".config/git/config" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix_config/hm_config/dots/.gitconfig";
    };
  };
}
