# Sway compositor:
# https://github.com/swaywm/sway
#
# Previously a plain file at ~/.config/sway/config (not HM-managed).
# Now managed via Home Manager — package, config, and systemd integration.
#
# swayidle is managed separately in config/swayidle.nix (systemd user service).
# swaylock is managed via programs.swaylock below.
#
# NOTE: The HM sway module generates the config file and validates it with
# `sway --validate`. We set checkConfig = false because the config references
# outputs (LVDS-1, HDMI-A-2, HDMI-A-3) that don't exist in the build sandbox.
#
# greetd integration: /etc/greetd/config.toml should use `agreety --cmd sway`
# (without the /usr/bin/ prefix) so PATH resolves to the HM-managed binary.
# That's a manual system-level edit (greetd is root-owned, outside HM on Arch).
{ pkgs, lib, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    # Don't validate at build time — config references outputs that
    # don't exist in the sandbox and would fail `sway --validate`.
    checkConfig = false;

    # systemd integration: imports WAYLAND_DISPLAY etc. into the systemd
    # user environment and starts sway-session.target on startup.
    # This replaces the /etc/sway/config.d/50-systemd-user.conf include.
    systemd.enable = true;

    # No structured keybindings — keymapper handles all bindings.
    # See ~/.config/keymapper.conf (managed by config/keymapper.nix).
    config = null;

    extraConfig = ''
      ### Output configuration
      output LVDS-1 resolution 1366x768 position 0 0
      output HDMI-A-3 resolution 1920x1080 position 1366 0
      output HDMI-A-2 resolution 1920x1080 position 3286 0

      ### Startup applications
      # exec wl-paste -n --primary --watch wl-copy
      # exec wl-paste -n --watch wl-copy
      # keymapper is managed by Home Manager (systemd user service)
      # swayidle is managed by Home Manager (systemd user service)
      exec /usr/share/sway-contrib/inactive-windows-transparency.py -o 0.55 -g

      ### Window handling
      # Annoyingly wayland doesn't have a window_role equivalent so dialogs need to be specified explicitly
      for_window [app_id="firefox" title="Extension: \(Bitwarden Password Manager\).*"] floating enable
      for_window [class="Pinentry-gtk"] floating enable
      for_window [app_id="qalculate-gtk"] floating enable

      ### Input configuration
      input type:keyboard {
          xkb_layout "ie"
      }

      ### Key bindings
      # Input config and key bindings are managed through Keymapper, see `~/.config/keymapper.conf`

      ### Status Bar:
      # bar {
      #     swaybar_command waybar
      # }
    '';
  };

  # ── swaylock ────────────────────────────────────────────────────────
  # PAM note: the nix swaylock package does NOT install /etc/pam.d/swaylock,
  # which is required for unlocking. On Arch, this file is shipped by the
  # pacman package. Before removing pacman's swaylock, copy the PAM file:
  #   sudo cp /etc/pam.d/swaylock /etc/pam.d/swaylock.bak
  #   # ... after pacman -R swaylock ...
  #   sudo cp /etc/pam.d/swaylock.bak /etc/pam.d/swaylock
  # The file just does `auth include login` so it's stable across versions.
  programs.swaylock = {
    enable = true;
    settings = {
      color = "000000";
      font-size = 24;
      indicator-idle-visible = false;
      indicator-radius = 100;
      line-color = "ffffff";
      show-failed-attempts = true;
    };
  };
}