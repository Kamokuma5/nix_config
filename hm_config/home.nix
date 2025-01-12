{ config, pkgs, ... }:

{
  programs = {
    git = (import ./hm_modules/git.nix { inherit pkgs; });
  };

  home = {
    packages = with pkgs; [
      neovim
      wget
      eza
      dust
      fuc
      zoxide
      fzf
      zellij
      tmux
      fastfetch
      vesktop
      vscode
      youtube-music
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
