{ config, pkgs, lib, system, inputs, ... }:
{
  home.packages = with pkgs; [
    # brightnessctl         # screen brightness control
    # hyprshot              # Screenshots
    rofi-wayland
    rofi-bluetooth
    # libnotify
    # hypridle
    # hyprlock

    # hyprpanel widget
    hyprpanel
    networkmanagerapplet

    # fabric widgets
    pkgs.nvtopPackages.full
    pkgs.cava
    pkgs.matugen
    pkgs.acpi
    pkgs.brightnessctl
    pkgs.gnome-bluetooth
    pkgs.gpu-screen-recorder
    pkgs.grimblast
    pkgs.hypridle
    pkgs.hyprlock
    pkgs.hyprpicker
    pkgs.hyprsunset
    pkgs.imagemagick
    pkgs.libnotify
    pkgs.noto-fonts-color-emoji
    pkgs.swappy
    pkgs.swww
    pkgs.hyprshot
    pkgs.tesseract
    pkgs.uwsm
    pkgs.cantarell-fonts
    pkgs.wl-clipboard
    pkgs.wlinhibit
    pkgs.tmux
    pkgs.webp-pixbuf-loader

    (inputs.fabric.packages."${system}".run-widget.override { 
      extraPythonPackages = with pkgs.python3Packages; [
        ijson
        pillow
        psutil
        requests
        setproctitle
        toml
        numpy
        watchdog
      ];
      
      extraBuildInputs = [
        inputs.gray.packages."${system}".gray
        pkgs.networkmanager
        pkgs.playerctl
      ]; 
    })
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