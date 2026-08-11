# Desktop environment — compositor, terminal, input, clipboard
{ pkgs, lib, ... }:
{
  imports = [
    ./sway/default.nix
    ./keymapper/default.nix
    ./clipcat.nix
    ./terminal.nix
    ./tools.nix
  ];

  # ── System integration checks ───────────────────────────────────────
  # Combined activation check for system-level files that HM can't manage
  # (they require root/sudo). Runs after writeBoundary so the new generation
  # is in place. Only prints warnings — doesn't block activation.
  home.activation.checkSystemIntegration = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    WARNINGS=""

    # keymapperd: system service must point at the current nix store path
    KEYMAPPERD_BIN="${pkgs.keymapper}/bin/keymapperd"
    UNIT_FILE="/etc/systemd/system/keymapperd.service"
    if [ ! -f "$UNIT_FILE" ]; then
      WARNINGS="$WARNINGS
  ⚠ keymapperd: system service not installed.
    Run: sudo keymapper-install-systemd"
    elif ! grep -q "$KEYMAPPERD_BIN" "$UNIT_FILE" 2>/dev/null; then
      WARNINGS="$WARNINGS
  ⚠ keymapperd: system service needs updating (stale binary path).
    Run: sudo keymapper-install-systemd"
    fi

    # swaylock: PAM file + unix_chkpwd wrapper must exist for unlocking
    if [ ! -f /etc/pam.d/swaylock ] || [ ! -L /run/wrappers/bin/unix_chkpwd ]; then
      WARNINGS="$WARNINGS
  ⚠ swaylock: PAM setup incomplete.
    Run: sudo swaylock-install-pam"
    fi

    if [ -n "$WARNINGS" ]; then
      echo ""
      echo "$WARNINGS"
      echo ""
    fi
  '';
}