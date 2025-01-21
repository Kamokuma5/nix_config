{ config, pkgs, ... }:

{
  programs = {
    git = (import ./hm_modules/git.nix { inherit pkgs; });
  };

  home = {
    packages = with pkgs; [
      # Hyprland
      brightnessctl    # Needed for screen brightness control
      hyprpanel
      networkmanagerapplet
      hyprshot
      rofi-wayland
      rofi-bluetooth
      libnotify
      hypridle
      hyprlock
      hyprnotify
      waybar

      # CLI Tools
      foot
      neovim
      wget
      eza
      dust
      # fuc
      zoxide
      fzf
      zellij
      tmux
      fastfetch

      # Apps
      vesktop
      vscode
      youtube-music
      
      # LLMs
      nvidia-container-toolkit
      python311
    ];

    username = "duck";
    homeDirectory = "/home/duck";

    sessionVariables = {
      EDITOR = "nvim";
    };

    stateVersion = "24.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
