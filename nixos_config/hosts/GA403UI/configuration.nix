{ config, pkgs, lib, inputs, ... }:

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
      ../../nixos_modules/de.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "${host_name}";

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable networking
  networking.networkmanager.enable = true;

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

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = false;

  services.displayManager.sddm.wayland.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;       # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true;  # powers up the default Bluetooth controller on boot
  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
    };
  };
  #services.blueman.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user_name} = {
    isNormalUser = true;
    description = "${user_name}";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "${user_name}";

  # Install firefox.
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    home-manager
  ];

  fonts.packages = with pkgs; [
    cascadia-code
  ];

  system.stateVersion = "24.11"; # Did you read the comment?
}
