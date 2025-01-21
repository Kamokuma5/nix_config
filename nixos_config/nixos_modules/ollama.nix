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
    models = "/home/duck/.ollama/models/";
  };
}