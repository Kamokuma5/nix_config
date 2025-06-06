{ config, pkgs, inputs, ... }:
let
  nix_secrets = import "${inputs.nix_secrets}/secrets.nix";
in
{
  imports = [
    inputs.hyprpanel.homeManagerModules.hyprpanel
    ./hm_modules/hyprland.nix
    ./hm_modules/zsh.nix
    ./hm_modules/git.nix 
    ./hm_modules/foot.nix
    ./hm_modules/fastfetch.nix
    ./hm_modules/mime.nix
  ];

  programs = {
    hyprpanel = (import ./hm_modules/hyprpanel.nix { inherit pkgs nix_secrets; });
  };

  nixpkgs.config.allowUnfree = true;
  home = {
    packages = with pkgs; [
      # CLI Tools
      foot
      neovim
      wget
      eza
      dust
      zoxide
      fzf
      zellij
      tmux
      fastfetch
      btop-rocm
      yazi
      tree
      bat
      powertop
      lazydocker

      # Apps
      vesktop
      vscode
      youtube-music
      microsoft-edge
      mpv
      inputs.zen-browser.packages."${system}".twilight
      
      # LLMs
      nvidia-container-toolkit
    ];

    username = "duck";
    homeDirectory = "/home/duck";

    stateVersion = "24.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
