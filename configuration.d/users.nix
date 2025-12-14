{config, pkgs, ...}:

{
  users.users.memphis = {
    isNormalUser = true;
    home = "/home/memphis";
    extraGroups = [ "wheel" "docker" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII+2AUc0iIPsc2sEkOa3awkbqlIbOf8lopEnYQuJpxxh Memphis Herghelegiu"
    ];
  };
}
