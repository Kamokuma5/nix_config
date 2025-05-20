{ config, pkgs, lib, system, inputs, ... }:
{
  home.packages = with pkgs; [
    brightnessctl         # screen brightness control
    hyprshot              # Screenshots
    rofi-wayland
    rofi-bluetooth
    libnotify
    hypridle
    hyprlock

    # hyprpanel widget
    hyprpanel
    networkmanagerapplet
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