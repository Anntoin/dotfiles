{ pkgs, config, lib, ... }:
# Keymapper — context-aware key remapper
# This module manages the config, the user client service, and provides
# a script to install the system-level keymapperd daemon unit.
{
  home.packages = with pkgs; [
    keymapper
    # Script to install/update the system-level keymapperd.service unit.
    # Run with sudo after `home-manager switch` if the reminder prints:
    #   sudo keymapper-install-systemd
    (writeShellScriptBin "keymapper-install-systemd"
      (builtins.replaceStrings
        [ "@KEYMAPPERD@" ]
        [ "${pkgs.keymapper}/bin/keymapperd" ]
        (builtins.readFile ./scripts/keymapper-install-systemd.sh)))
  ];

  xdg.configFile = {
    "keymapper.conf" = {
      source = ./keymapper.conf;
    };
    "keymapper.conf.d/key_aliases.conf" = {
      source = ./key_aliases.conf;
    };
    "keymapper.conf.d/window_matchers.conf" = {
      source = ./window_matchers.conf;
    };
    "keymapper.conf.d/virtual_keys.conf" = {
      source = ./virtual_keys.conf;
    };
  };

  systemd.user.services.keymapper = {
    Unit = {
      Description = "Keymapper client (auto-reload on config change)";
      After = [ "default.target" ];
    };
    Service = {
      Type = "simple";
      ExecStartPre = [
        "${pkgs.coreutils}/bin/mkdir -p %h/.local/state/keymapper"
        # Wait for keymapperd's @keymapper socket to be listening.
        # The daemon starts at system scope (multi-user.target) and creates
        # the abstract socket immediately, but input devices may still be
        # enumerating at boot (USB keyboards, mice). We wait for the socket
        # to ensure the daemon is at least accepting connections.
        "${pkgs.bash}/bin/bash -c 'for i in $(seq 1 30); do grep -q keymapper /proc/net/unix 2>/dev/null && exit 0; sleep 0.5; done; echo \"keymapperd socket not found after 15s\"; exit 1'"
      ];
      ExecStart = "${pkgs.keymapper}/bin/keymapper -u";
      # The config executes shell commands (kitty, tofi, swaymsg, brightnessctl,
      # ddcutil, etc.) via $(...). The systemd user manager only has
      # /usr/local/bin:/usr/bin on PATH — nix-profile and ~/.local/bin are
      # missing. Restore the user's PATH so command lookups succeed.
      Environment = [
        "PATH=%h/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:%h/.local/bin"
      ];
      # keymapper spawns child processes via fork()+execl() for $(...) commands
      # in the config (kitty, tofi, etc.). These children stay in the service
      # cgroup. With the default KillMode=control-group, restarting the service
      # would kill all spawned terminals. KillMode=process ensures only the
      # keymapper process itself is signalled — spawned terminals survive.
      # Combined with SOCK_CLOEXEC on the control port socket (upstream patch),
      # a restarted keymapper can rebind @keymapperctl without conflict.
      KillMode = "process";
      Restart = "on-failure";
      RestartSec = 3;
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  # One-shot service that restarts keymapper after boot to force a clean
  # re-handshake with keymapperd. At boot, USB input devices enumerate after
  # keymapper's initial connection, causing keymapperd to re-scan devices
  # but the client doesn't re-send config — keybindings silently fail.
  # A systemd timer (OnBootSec) triggers this service, which restarts
  # keymapper.service. We can't just use a timer with Unit=keymapper.service
  # because that does a "start" (no-op if already running), not a "restart".
  systemd.user.services.keymapper-boot-restart = {
    Unit = {
      Description = "Restart keymapper after boot device enumeration settles";
      After = [ "keymapper.service" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'sleep 10; systemctl --user restart keymapper.service'";
    };
  };

  systemd.user.timers.keymapper-boot-restart = {
    Unit = {
      Description = "Trigger keymapper boot restart after devices settle";
    };
    Timer = {
      OnBootSec = "10s";
      AccuracySec = "2s";
      Unit = "keymapper-boot-restart.service";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  # System integration check moved to config/desktop/default.nix
  # (combined with swaylock PAM check as checkSystemIntegration).
}