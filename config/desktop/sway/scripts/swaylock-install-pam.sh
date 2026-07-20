set -euo pipefail

# 1. PAM service file — nix swaylock doesn't install /etc/pam.d/swaylock.
PAM_FILE="/etc/pam.d/swaylock"
cat > "$PAM_FILE" <<EOF
#
# PAM configuration file for the swaylock screen locker. By default, it includes
# the 'login' configuration file (see /etc/pam.d/login)
#

auth include login
EOF
echo "Installed $PAM_FILE"

# 2. unix_chkpwd wrapper symlink — nix's pam_unix.so looks for the setuid
#    helper at /run/wrappers/bin/unix_chkpwd (NixOS wrapper path). On Arch
#    that directory doesn't exist. Symlink to Arch's setuid unix_chkpwd
#    so nix's PAM stack can authenticate against /etc/shadow.
#    See: hm-sway-compositor skill, swaylock PAM on Arch section.
WRAPPER_DIR="/run/wrappers/bin"
WRAPPER="$WRAPPER_DIR/unix_chkpwd"
ARCH_CHKPWD="/usr/sbin/unix_chkpwd"

mkdir -p "$WRAPPER_DIR"
ln -sf "$ARCH_CHKPWD" "$WRAPPER"

echo "Symlinked $WRAPPER -> $ARCH_CHKPWD"

# 3. tmpfiles.d snippet — /run is tmpfs, so the symlink survives reboots
#    via systemd-tmpfiles. This is idempotent.
TMPFILES_CONF="/etc/tmpfiles.d/nix-pam-wrappers.conf"
cat > "$TMPFILES_CONF" <<EOF
# Created by swaylock-install-pam — provides /run/wrappers/bin/unix_chkpwd
# so nix's pam_unix.so can find Arch's setuid helper.
d $WRAPPER_DIR 0755 root root -
L $WRAPPER     - - - - $ARCH_CHKPWD
EOF
echo "Installed $TMPFILES_CONF (applies on reboot via systemd-tmpfiles)"