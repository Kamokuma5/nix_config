{ config, pkgs, lib, ... }:

{
  home.file = {
    ".config/foot/foot.ini" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix_config/hm_config/dots/foot.ini";
    };
  };
}