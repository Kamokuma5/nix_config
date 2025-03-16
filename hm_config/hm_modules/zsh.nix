{ config, pkgs, lib, ... }:

{  
  home.packages = with pkgs; [
      zsh
  ];

  home.file = {
    ".zshrc" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix_config/hm_config/dots/.zshrc";
    };
    "zsh-autosuggestions" = {
      source = builtins.fetchGit {
        url = "https://github.com/zsh-users/zsh-autosuggestions";
        ref = "refs/tags/v0.7.1";
      };
    };
    "powerlevel10k" = {
      source = builtins.fetchGit {
        url = "https://github.com/romkatv/powerlevel10k";
        ref = "refs/tags/v1.20.0";
      };
    };
    ".p10k.zsh" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix_config/hm_config/dots/.p10k.zsh";
    };
  };
}