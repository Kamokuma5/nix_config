{
  config,
  pkgs,
  lib,
  ...
}:

{
  hardware.nvidia-container-toolkit.enable = true;
  virtualisation.docker.enable = true;
  # virtualisation.docker.rootless = {
  #   enable = true;
  #   setSocketVariable = true;
  # };
}