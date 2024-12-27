{
  config,
  pkgs,
  lib,
  ...
}:

{
  # KDE Plasma
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = [
    pkgs.kitty # required for the default Hyprland config
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
