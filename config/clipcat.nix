# Clipboard manager:
# https://github.com/xrelkd/clipcat
#
# Previously installed via pacman with manual config files in ~/.config/clipcat/.
# Now managed via Home Manager — package, config, and systemd user service.
#
# The HM module's systemd service uses PartOf = graphical-session.target,
# so this must be in a desktop-only module (not shell.nix).
#
# NOTE: The upstream HM module's ExecStart/ExecStartPre scripts hardcode
# PATH=/run/current-system/sw/bin which is a NixOS path that doesn't
# exist on Arch. We override the service below to use a real PATH.
{ pkgs, lib, ... }:
{
  # ── Daemon config ──────────────────────────────────────────────────
  services.clipcat = {
    enable = true;

    daemonSettings = {
      # Keep as a foreground process — the systemd unit uses --no-daemon
      # so this flag is effectively ignored by the service, but keeps
      # the config file consistent if clipcatd is ever run manually.
      daemonize = true;
      pid_file = "/run/user/1000/clipcatd.pid";
      primary_threshold_ms = 5000;
      max_history = 50;
      clear_history_on_start = false;
      synchronize_selection_with_clipboard = true;
      history_file_path = "/home/anntoin/.cache/clipcat/clipcatd-history";
      snippets = [ ];

      log = {
        emit_journald = true;
        emit_stdout = false;
        emit_stderr = false;
        level = "INFO";
      };

      watcher = {
        enable_clipboard = true;
        enable_primary = true;
        enable_secondary = false;
        sensitive_mime_types = [ "x-kde-passwordManagerHint" ];
        filter_text_min_length = 1;
        filter_text_max_length = 20000000;
        denied_text_regex_patterns = [ ];
        capture_image = true;
        filter_image_max_size = 5242880;
      };

      grpc = {
        enable_http = true;
        enable_local_socket = true;
        host = "127.0.0.1";
        port = 45045;
        local_socket = "/run/user/1000/clipcat/grpc.sock";
      };

      dbus.enable = true;

      metrics = {
        enable = true;
        host = "127.0.0.1";
        port = 45047;
      };

      desktop_notification = {
        enable = true;
        icon = "accessories-clipboard";
        timeout_ms = 2000;
        long_plaintext_length = 2000;
      };
    };

    ctlSettings = {
      server_endpoint = "/run/user/1000/clipcat/grpc.sock";
      preview_length = 100;
      show_source_prefix = false;
      grpc_max_message_size = 8388608;

      log = {
        emit_journald = true;
        emit_stdout = false;
        emit_stderr = false;
        level = "INFO";
      };
    };

    menuSettings = {
      server_endpoint = "/run/user/1000/clipcat/grpc.sock";
      # fuzzel is installed via HM (desktop-tools.nix), rofi is not
      finder = "fuzzel";
      preview_length = 80;
      grpc_max_message_size = 8388608;

      fuzzel = {
        line_length = 100;
        menu_length = 30;
        menu_prompt = "Clipcat";
        extra_arguments = [ ];
        show_source_prefix = false;
      };

      # Keep defaults for other finders in case of manual switch
      rofi = {
        line_length = 100;
        menu_length = 30;
        menu_prompt = "Clipcat";
        extra_arguments = [ ];
        show_source_prefix = false;
      };

      dmenu = {
        line_length = 100;
        menu_length = 30;
        menu_prompt = "Clipcat";
        extra_arguments = [ ];
        show_source_prefix = false;
      };

      custom_finder = {
        program = "fzf";
        args = [ ];
      };

      log = {
        emit_journald = true;
        emit_stdout = false;
        emit_stderr = false;
        level = "INFO";
      };
    };
  };

  # ── Override the upstream systemd service ──────────────────────────
  # The HM module's scripts hardcode PATH=/run/current-system/sw/bin
  # (a NixOS path). On Arch, rm and other coreutils live in /usr/bin.
  # We rebuild the service with a working PATH.
  systemd.user.services.clipcat = {
    Service = {
      ExecStartPre = lib.mkForce [
        "-${pkgs.coreutils}/bin/rm -f %t/clipcat/grpc.sock"
      ];
      ExecStart = lib.mkForce "${pkgs.clipcat}/bin/clipcatd --no-daemon --replace";
      Environment = [
        "PATH=${pkgs.coreutils}/bin:${pkgs.findutils}/bin:/usr/bin"
      ];
    };
  };
}