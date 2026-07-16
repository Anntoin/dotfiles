{ pkgs, config, lib, ... }:
# Keymapper — context-aware key remapper
# Binary: keymapper 5.6.0 from nixpkgs
# This module manages the config, the user client service, and provides
# a script to install the system-level keymapperd daemon unit.
{
  home.packages = with pkgs; [
    keymapper
    # Script to install/update the system-level keymapperd.service unit.
    # Run with sudo after `home-manager switch` if the reminder prints:
    #   sudo keymapper-install-systemd
    (writeShellScriptBin "keymapper-install-systemd" ''
      set -euo pipefail
      UNIT_DIR="/etc/systemd/system"
      UNIT_FILE="$UNIT_DIR/keymapperd.service"
      KEYMAPPERD="${pkgs.keymapper}/bin/keymapperd"

      # Generate the system unit with the absolute nix-store path.
      # The upstream unit uses a bare "ExecStart=keymapperd" which relies on
      # the binary being on the system PATH — not the case for nix installs.
      cat > "$UNIT_FILE" <<EOF
[Unit]
Description=Keymapper Daemon
# Start as early as possible — the user client (keymapper -u) waits for
# the @keymapper socket, but the daemon needs time to enumerate input
# devices and create the virtual keyboard before the client connects.
After=sysinit.target

[Service]
ExecStart=$KEYMAPPERD

[Install]
WantedBy=multi-user.target
EOF

      systemctl daemon-reload

      if systemctl is-active --quiet keymapperd; then
        systemctl restart keymapperd
        echo "keymapperd.service updated and restarted."
      else
        systemctl enable --now keymapperd
        echo "keymapperd.service installed and enabled."
      fi
    '')
  ];

  xdg.configFile = {
    "keymapper.conf" = {
      source = ./keymapper/keymapper.conf;
    };
    "keymapper.conf.d/key_aliases.conf" = {
      source = ./keymapper/key_aliases.conf;
    };
    "keymapper.conf.d/window_matchers.conf" = {
      source = ./keymapper/window_matchers.conf;
    };
    "keymapper.conf.d/virtual_keys.conf" = {
      source = ./keymapper/virtual_keys.conf;
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

  # One-shot timer that restarts keymapper 10s after user session starts.
  # At boot, USB input devices enumerate after keymapper's initial
  # connection to keymapperd. The daemon re-scans devices but the client
  # doesn't re-send config — keybindings silently fail. This timer forces
  # a single restart after devices have settled, establishing a clean
  # re-handshake. Harmless on `home-manager switch` (just restarts once).
  systemd.user.timers.keymapper-boot-restart = {
    Unit = {
      Description = "Restart keymapper after boot device enumeration settles";
    };
    Timer = {
      OnBootSec = "10s";
      OnUnitActiveSec = "0";
      AccuracySec = "2s";
      Unit = "keymapper.service";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  # Reminder: check if the system-level keymapperd.service needs updating
  # after home-manager switch. The daemon runs as a system service because
  # it needs raw input device access (evdev/uinput).
  home.activation.checkKeymapperdSystemd = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    KEYMAPPERD_BIN="${pkgs.keymapper}/bin/keymapperd"
    UNIT_FILE="/etc/systemd/system/keymapperd.service"
    NEEDS_UPDATE=false

    if [ ! -f "$UNIT_FILE" ]; then
      NEEDS_UPDATE=true
    elif ! grep -q "$KEYMAPPERD_BIN" "$UNIT_FILE" 2>/dev/null; then
      NEEDS_UPDATE=true
    fi

    if [ "$NEEDS_UPDATE" = true ]; then
      echo ""
      echo "  ⚠ keymapperd: system service needs updating."
      echo "    Run: sudo keymapper-install-systemd"
      echo "    (installs/updates /etc/systemd/system/keymapperd.service"
      echo "     to use $KEYMAPPERD_BIN)"
      echo ""
    fi
  '';
}