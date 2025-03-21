{
  config,
  pkgs,
  lib,
  ...
}:

{
  # hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.ELECTRON_OZONE_PLATFORM_HINT = "wayland";

  # Use iGPU to render hyprland
  environment.sessionVariables.AQ_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
  
  # Hyprland
  programs.hyprland = {
    enable = true;
    # xwayland.enable = true;
  };

  # Hyprland programs
  environment.systemPackages = [
    pkgs.kitty            # required for the default Hyprland config
  ];

  # Thunar File Manager
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
}
