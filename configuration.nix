{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

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

  environment.systemPackages = with pkgs; [
    openssh
    docker
    docker-compose
    neovim
    zfs
    htop
    git
  ];

  virtualisation.docker.enable = true;
  
  users.users.memphis = {
    isNormalUser = true;
    home = "/home/memphis";
    extraGroups = [ "wheel" "docker" ];
  };

  services.openssh = {
    enable = true;
    # settings.PermitRootLogin = "yes";
    settings.PasswordAuthentication = true;
  };

  fileSystems."/home" = {
    device = "nvme_pool";
    fsType = "zfs";
    options = [ "defaults" "nofail" ];
  };

  system.stateVersion = "25.11";
}
