{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./configuration.d/packages.nix
    ./configuration.d/restart.nix
    ./configuration.d/users.nix
  ];

  console.keyMap = "de";

  boot.kernelPackages = pkgs.linuxPackages_6_6;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "zfs" ];
  boot.supportedFilesystems = [ "zfs" ];

  networking = {
    hostId = "2D955F20";
    hostName = "server";
    networkmanager.enable = true;
    firewall.enable = false;
    interfaces = {
      enp34s0 = {
        wakeOnLan.enable = true;
      };
    };
  };

  time.timeZone = "Europe/Berlin";

  virtualisation.docker.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  fileSystems."/home" = {
    device = "nvme_pool";
    fsType = "zfs";
    options = [ "defaults" "nofail" ];
  };

  system.stateVersion = "25.11";
}
