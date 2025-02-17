{
  config,
  pkgs,
  lib,
  ...
}:

{
  # This service runs once on startup to set default power values
  systemd.services.power_mgmt_init = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      User = "root";
      Group = "root";
      Type = "oneshot";
      RemainAfterExit = true;
    };
    path = with pkgs; [ 
      coreutils
      gawk
      sudo
    ];
    script = (builtins.readFile ./init.sh);
  };
}