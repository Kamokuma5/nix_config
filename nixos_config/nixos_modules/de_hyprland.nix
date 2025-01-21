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
  # environment.sessionVariables.AQ_DRM_DEVICES = "/dev/dri/card1";
  
  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Hyprland programs
  environment.systemPackages = [
    pkgs.kitty            # required for the default Hyprland config
  ];
}
