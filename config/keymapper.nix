{ pkgs, config, ... }:
# Keymapper — context-aware key remapper
# Binary: AUR keymapper-git (5.5.0), system daemon stays as keymapperd.service
# This module manages the config and the user client service.
{
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
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %h/.local/state/keymapper";
      ExecStart = "/usr/bin/keymapper -u";
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
}