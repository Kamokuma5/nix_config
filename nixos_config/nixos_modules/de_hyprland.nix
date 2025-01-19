{
  config,
  pkgs,
  lib,
  ...
}:

{
  # hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Use iGPU to render hyprland
  environment.sessionVariables.AQ_DRM_DEVICES = "/dev/dri/card1";
  
  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Hyprland programs
  environment.systemPackages = [
    pkgs.brightnessctl    # Needed for brightness control
    pkgs.kitty            # required for the default Hyprland config
    pkgs.foot
    pkgs.hyprpanel
    pkgs.networkmanagerapplet
    pkgs.hyprshot
    pkgs.rofi-wayland
    pkgs.rofi-bluetooth

    pkgs.libnotify
    pkgs.hypridle
    
    pkgs.hyprlock
    pkgs.hyprnotify
    
    pkgs.waybar
  ];
}
