{
  config,
  pkgs,
  lib,
  ...
}:

{
  # hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  
  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Hyprland programs
  environment.systemPackages = [
    pkgs.kitty # required for the default Hyprland config
    pkgs.foot
    pkgs.hyprpanel
    pkgs.waybar
    pkgs.networkmanagerapplet
    pkgs.hyprshot
    pkgs.rofi-wayland
    pkgs.rofi-bluetooth
    pkgs.hypridle
    pkgs.hyprlock
    pkgs.hyprnotify
  ];
}
