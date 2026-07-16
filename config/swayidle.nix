# Idle manager:
# https://github.com/swaywm/swayidle
#
# Previously launched via `exec swayidle -w ...` in ~/.config/sway/config.
# Now managed via Home Manager — package and systemd user service.
#
# The HM module's systemd service uses PartOf = graphical-session.target,
# so this must be in a desktop-only module (not shell.nix).
#
# NOTE: The upstream HM module sets Environment PATH to only include bash
# (for swayidle's `sh -c` command execution). The timeout/event commands
# (swaylock, swaymsg) are HM-managed nix packages — we add their bin dirs
# to PATH below so swayidle can find them.
{ pkgs, lib, ... }:
{
  services.swayidle = {
    enable = true;

    # Lock screen after 300s inactivity, then power off displays.
    # Both timeouts fire at 300s (intentional — lock + display off together).
    timeouts = [
      {
        timeout = 300;
        command = "swaylock -f -c 000000";
      }
      {
        timeout = 300;
        command = ''swaymsg "output * power off"'';
        resumeCommand = ''swaymsg "output * power on"'';
      }
    ];

    # Lock screen before system sleeps
    events = {
      before-sleep = "swaylock -f -c 000000";
    };

    # -w is already the default in extraArgs
  };

  # ── Override the upstream systemd service PATH ─────────────────────
  # The HM module sets PATH to only ${makeBinPath [ pkgs.bash ]} so that
  # swayidle's `sh -c` can find a shell. But the timeout/event commands
  # need swaylock and swaymsg in PATH. Both are HM-managed (nix packages),
  # so we add their bin dirs alongside bash.
  systemd.user.services.swayidle = {
    Service = {
      Environment = lib.mkForce [
        "PATH=${pkgs.bash}/bin:${pkgs.swaylock}/bin:${pkgs.sway}/bin"
      ];
    };
  };
}