set -euo pipefail
UNIT_DIR="/etc/systemd/system"
UNIT_FILE="$UNIT_DIR/keymapperd.service"
KEYMAPPERD="@KEYMAPPERD@"

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