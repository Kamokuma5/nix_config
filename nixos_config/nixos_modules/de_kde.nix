{
  config,
  pkgs,
  lib,
  ...
}:

{
  # hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # KDE Plasma Wayland
  services.displayManager.sddm.enable = true;
  services.xserver.enable = false;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  
  # KDE programs
  programs.kdeconnect.enable = true;
  environment.systemPackages = with pkgs; [
    kdePackages.plasma-browser-integration
    supergfxctl-plasmoid
  ];
}
