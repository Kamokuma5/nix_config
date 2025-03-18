{ config, pkgs, lib, inputs, outputs, pkgs_unstable, ... }:

{
  programs = {
    # Enable temp tweaks for games
    gamemode.enable = true;

    # Micro compositor for games
    gamescope = {
      enable = true;
      capSysNice = true;
    };

    steam = {
      enable = true;
      gamescopeSession.enable = true;
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      protontricks.enable = true;
    };
  };

  environment.systemPackages = [
    pkgs.steam-run
    pkgs.mangohud
    pkgs.bottles
    pkgs_unstable.amdgpu_top
    pkgs_unstable.mesa-demos
  ];
}