{config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    openssh
    docker
    docker-compose
    zfs
    git
  ];
}
