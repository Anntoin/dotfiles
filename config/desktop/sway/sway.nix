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
let
  # inactive-windows-transparency.py from sway-contrib.
  # Not packaged in nixpkgs, so we wrap it as a simple derivation
  # with its only dependency: python3-i3ipc.
  inactive-windows-transparency = let
    pythonEnv = pkgs.python3.withPackages (p: [ p.i3ipc ]);
  in pkgs.stdenv.mkDerivation {
    pname = "inactive-windows-transparency";
    version = "unstable-2024-01-01";
    src = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/OctopusET/sway-contrib/master/inactive-windows-transparency.py";
      hash = "sha256-IOuSkQa+W4/+DeKNdhDCD7v++8/5WAGGsEeFOL4YH0o=";
    };
    dontUnpack = true;
    installPhase = ''
      runHook preInstall
      install -Dm755 $src $out/bin/inactive-windows-transparency.py
      # Replace the shebang with our nix python env
      sed -i '1s|.*|#!${pythonEnv}/bin/python|' $out/bin/inactive-windows-transparency.py
      runHook postInstall
    '';
  };
in
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
      exec ${inactive-windows-transparency}/bin/inactive-windows-transparency.py -o 0.55 -g

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
  # The nix swaylock package does NOT install /etc/pam.d/swaylock, which is
  # required for unlocking. On Arch, this file is shipped by the pacman
  # package. We provide a sudo script to install it (same pattern as
  # keymapper-install-systemd in config/keymapper.nix).
  #
  # The PAM file is trivially stable: `auth include login`.
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

  # Script to install/repair the PAM file for swaylock.
  # Run with sudo after `home-manager switch` if the reminder prints:
  #   sudo swaylock-install-pam
  home.packages = [
    (pkgs.writeShellScriptBin "swaylock-install-pam"
      (builtins.readFile ./scripts/swaylock-install-pam.sh))
  ];

  # System integration check moved to config/desktop/default.nix
  # (combined with keymapperd check as checkSystemIntegration).
}