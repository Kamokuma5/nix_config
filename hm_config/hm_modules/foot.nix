{ config, pkgs, lib, ... }:

{
  home.file = {
    ".config/foot/foot.ini" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/duck/nix_config/hm_config/dots/foot.ini";
    };
  };
}