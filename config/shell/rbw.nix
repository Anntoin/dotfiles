{ pkgs, ... }:
# CLI for bitwarden
# https://github.com/doy/rbw
{
  programs.rbw = {
    enable = true;
    settings = {
      base_url = "https://secrets.anntoin.com";
      email = "anntoin@gmail.com";
      pinentry = pkgs.pinentry-tty;
      lock_timeout = 4294967295;
    };
  };

  # ── rbw SSH agent service ──────────────────────────────────────────
  # rbw-agent provides the SSH agent socket that SSH_AUTH_SOCK points
  # to. Without this service the agent only starts on-demand when a
  # `rbw` CLI command is run, which means SSH connections fail (hang or
  # "agent refused operation") when no rbw command has been invoked
  # recently — e.g. after a reboot or if the agent died.
  #
  # The agent still auto-locks after `lock_timeout` (config: 3600s/1h);
  # running `rbw unlock` will unlock it again. The service ensures the
  # *process* and the *socket* are always present, not that the vault is
  # always unlocked.
  systemd.user.services.rbw-agent = {
    Unit = {
      Description = "rbw Bitwarden agent (SSH agent + password vault)";
      # default.target is active on both desktop and server hosts (it's the
      # main user session target). graphical-session.target is inactive on
      # headless hosts, so we can't rely on it.
      After = [ "default.target" ];
    };
    Service = {
      # --no-daemonize keeps the process in the foreground so systemd
      # can track it directly with Type=simple. The agent still writes
      # its pidfile and takes an exclusive lock on it, so only one
      # instance can run at a time.
      Type = "simple";
      ExecStart = "${pkgs.rbw}/bin/rbw-agent --no-daemonize";
      Restart = "on-failure";
      RestartSec = 5;
      Environment = [
        "XDG_RUNTIME_DIR=%t"
        "XDG_CONFIG_HOME=%h/.config"
        "XDG_DATA_HOME=%h/.local/share"
      ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}