{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "Workstation-Server";

  # Networking with static IP
  networking.useNetworkd = true;
  services.resolved.enable = true;
  networking.networkmanager.enable = false;
  networking.interfaces.enp37s0.ipv4.addresses = [{
    address = "192.168.178.176";
    prefixLength = 24;
  }];
  networking.defaultGateway = {
    address = "192.168.178.1";
    interface = "enp37s0";
  };
  networking.nameservers = [ "1.1.1.1" "192.168.178.1" ];

  # Set your time zone.
  time.timeZone = "Europe/Berlin";
  
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11 (apparently for directly plugged in keyboards)
  services.xserver.xkb = {
    layout = "us";
    variant = "eurkey";
  };
  console.useXkbConfig = true;

  # The personal admin user
  users.users."felix" = {
    isNormalUser = true;
    description = "Felix";
    extraGroups = [ "wheel" "video" "render" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO7hjdiYFf4xcm9Me9hmNus1GzSOcyj0VNyGEffSDaRo mobile@localhost" # iPad
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBLfCCh1G0zd8vXgS8aGPZO0ruW+AtAmAznCy1o8CBqI PC-F"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEMgGZKX8GN6UhAg81JOQRXHEP6JnL9oeZgGbBAYq3wt u0_a476@localhost" # Motorola Edge 40
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGm8KzWHMs1Js88AYGgY/QuMUUYBJc6jv7vJtXXePje4 felix@felix-mobile"
    ];
    packages = [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run: `nix search wget`
  environment.systemPackages = with pkgs; [
    graalvmPackages.graalvm-ce
  ];

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false; # Completely blocks normal password entry via SSH
      KbdInteractiveAuthentication = false; # Blocks interactive keyboard prompts
      PermitRootLogin = "no"; # Root may NEVER log in directly (only felix via sudo)
    };
  };

  # Open ports in the firewall.
  # 22 = SSH
  # 25565 = Minecraft
  # 8080 = Open WebUI
  # 9200 = OpenCloud
  networking.firewall.allowedTCPPorts = [ 22 25565 8080 9200 ];
  # 24454 = Minecraft voice chat
  networking.firewall.allowedUDPPorts = [ 24454 ];

  # Just don't touch this
  system.stateVersion = "26.05"; # Did you read the comment?

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      ocl-icd
      rocmPackages.clr.icd # Includes the OpenCL runtime environment for AMD
    ];
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      ocl-icd
      stdenv.cc.cc.lib
      libGL
    ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Nix-Store Housekeeping - otherwise the disk will be full at some point
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  nix.settings.auto-optimise-store = true;
  services.journald.extraConfig = "SystemMaxUse=500M";

  # Automatic shut-down for the night
  systemd.timers.scheduled-shutdown = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "23:15";
      Unit = "poweroff.target";
      Persistent = false;
    };
  };

  services.xserver.enable = false;

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x1002", ATTR{device}=="0x743f", ATTR{power/control}="auto"
   
    ACTION=="add", SUBSYSTEM=="drm", KERNEL=="card*", ATTR{device/power_dpm_force_performance_level}="auto"
  '';

  systemd.services.hd-idle-hdd1 = {
    description = "Spindown HDD (Seagate) after idle";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.hdparm}/bin/hdparm -S 120 /dev/disk/by-id/ata-ST1000DM003-1SB102_ZN15QTXL";
    };
  };
  systemd.services.hd-idle-hdd2 = {
    description = "Spindown HDD (Toshiba) after idle";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.hdparm}/bin/hdparm -S 120 /dev/disk/by-id/ata-TOSHIBA_HDWD110_218TKVZFS";
    };
  };

  powerManagement.cpuFreqGovernor = "powersave";

  services.playit = {
    enable = true;
    secretPath = "/var/lib/playit/secret.toml";
  };

  services.open-webui = {
    enable = true;
    port = 8080;
    host = "0.0.0.0";
    environment = {
      OPENAI_API_BASE_URLS = "https://openrouter.ai/api/v1";
      WEBUI_AUTH = "true";
      ANONYMIZED_TELEMETRY = "false";
    };
  };

  services.opencloud = {
    enable = true;
    address = "0.0.0.0";
    port = 9200;
    url = "http://192.168.178.176:9200";
    environmentFile = "/etc/opencloud/secrets.env"; # JWT_SECRET, ADMIN_PASSWORD etc.
  };
}

