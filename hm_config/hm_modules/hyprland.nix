{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    brightnessctl         # screen brightness control
    hyprshot              # Screenshots
    hyprpanel
    networkmanagerapplet
    rofi-wayland
    rofi-bluetooth
    libnotify
    # hyprnotify
    hypridle
    hyprlock
    ags
  ];

  home.file = {
    ".config/hypr/hyprland.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/duck/nix_config/hm_config/dots/hyprland.conf";
    };
    ".config/hypr/hypridle.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/duck/nix_config/hm_config/dots/hypridle.conf";
    };
  };
}