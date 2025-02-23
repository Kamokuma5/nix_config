{ config, pkgs, lib, inputs, outputs, pkgs_unstable, ... }:

let
  host_name = "ga403ui";
  user_name = "duck";
  user_locale = "en_US.UTF-8";
in {
  imports =
  [
    ../../nixos_modules/asus-kernel.nix
    ../../nixos_modules/nvidia.nix
    ./hardware-configuration.nix
    ../../nixos_modules/de_kde.nix
    ../../nixos_modules/de_hyprland.nix
    ../../nixos_modules/docker.nix
    ../../nixos_modules/ollama.nix
    ../../nixos_modules/power_mgmt/power_mgmt.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # https://wiki.cachyos.org/configuration/general_system_tweaks/#enable-rcu-lazy
  # https://discourse.ubuntu.com/t/fine-tuning-the-ubuntu-24-04-kernel-for-low-latency-throughput-and-power-efficiency/44834
  boot.kernelParams = [
    "preempt=lazy"
    "rcu_nocbs=all" # RCUs will occur in kthreads instead of softirq context. Less interrupts = more idle time = better battery
    "rcutree.enable_rcu_lazy=1" # Defer RCU cleanup. Less kthread CPU time = less CPU wakeups when idling = better battery
  ];

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Networking
  networking.hostName = "${host_name}";
  networking.networkmanager.enable = true;

  # VPN
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "${user_locale}";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "${user_locale}";
    LC_IDENTIFICATION = "${user_locale}";
    LC_MEASUREMENT = "${user_locale}";
    LC_MONETARY = "${user_locale}";
    LC_NAME = "${user_locale}";
    LC_NUMERIC = "${user_locale}";
    LC_PAPER = "${user_locale}";
    LC_TELEPHONE = "${user_locale}";
    LC_TIME = "${user_locale}";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    extraConfig.pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 512;
        "default.clock.min-quantum" = 256;
        "default.clock.max-quantum" = 1024;
      };
    };
  };

  # Bluetooth
  hardware.bluetooth.enable = true;       # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true;  # powers up the default Bluetooth controller on boot
  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
    };
  };

  # udev
  services.udev.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user_name} = {
    isNormalUser = true;
    description = "${user_name}";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
    shell = pkgs.zsh;
  };

  # Set default shell to ZSH
  programs.zsh.enable = true;

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = false;
  services.displayManager.autoLogin.user = "${user_name}";

  # Default programs for all configs
  programs.firefox.enable = true;

  environment.systemPackages = [
    pkgs.git
    pkgs.home-manager
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
  ];

  system.stateVersion = "24.11"; # Did you read the comment?
}
