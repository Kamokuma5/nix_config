{
  config,
  pkgs,
  lib,
  ...
}:

{
  services.ollama = {
    enable = true;
    acceleration = "cuda";
    models = "${config.home.homeDirectory}/.ollama/models/";
  };
}