{config, pkgs, ...}:

{
  systemd.timers."midnight-reboot" = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "00:00";
      Persistent = true;
    };
  };

  systemd.services."midnight-reboot" = {
    script = ''systemctl reboot'';
    serviceConfig.Type = "oneshot";
  };
}
