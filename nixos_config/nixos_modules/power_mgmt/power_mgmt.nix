{
  config,
  pkgs,
  lib,
  ...
}:

let
  ac_pkg = pkgs.writeShellScriptBin "ac.sh" (builtins.readFile ./ac.sh);
  batt_pkg = pkgs.writeShellScriptBin "battery.sh" (builtins.readFile ./battery.sh);
in
{
  # Dependencies needed for power management shell scripts
  environment.systemPackages = [
    pkgs.pciutils
    ac_pkg
    batt_pkg
  ];

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
      pciutils
    ];
    script = (builtins.readFile ./init.sh);
  };

  
  services.udev.path = with pkgs; [ 
    coreutils
    gawk
    sudo
  ];

  # Trigger these scripts when power supply state changes
  services.udev.packages = lib.singleton (pkgs.writeTextFile
    { name = "power_mgmt_rules";
      text = ''
        SUBSYSTEM=="power_supply", ATTR{online}=="1", ATTR{type}=="Mains", RUN+="${ac_pkg}/bin/ac.sh"
        SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", RUN+="${batt_pkg}/bin/battery.sh"
      '';
      destination = "/etc/udev/rules.d/65-power_mgmt.rules";
    }
  );
}