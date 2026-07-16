set -euo pipefail
PAM_FILE="/etc/pam.d/swaylock"

cat > "$PAM_FILE" <<EOF
#
# PAM configuration file for the swaylock screen locker. By default, it includes
# the 'login' configuration file (see /etc/pam.d/login)
#

auth include login
EOF

echo "Installed $PAM_FILE"