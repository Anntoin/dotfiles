{ pkgs, config, ... }:
# SSH client configuration
# https://linux.die.net/man/5/ssh_config
let
  # ── sshd environment PATH ──────────────────────────────────────
  # ~/.ssh/environment is parsed as literal KEY=VAL — no shell
  # expansion — so $HOME in sessionPath entries must be substituted
  # to the real path.  Only stable (non-nix-store) paths are used;
  # ~/.nix-profile/bin and /nix/var/nix/profiles/default/bin are
  # symlinks that survive rebuilds.
  sshEnvPaths =
    let
      sessionPaths = map (p: builtins.replaceStrings ["$HOME"] [config.home.homeDirectory] p)
        config.home.sessionPath;
      stablePaths = [
        "${config.home.homeDirectory}/.nix-profile/bin"
        "/nix/var/nix/profiles/default/bin"
        "/usr/local/sbin"
        "/usr/local/bin"
        "/usr/bin"
      ];
    in
    sessionPaths ++ stablePaths;
  sshEnvPath = builtins.concatStringsSep ":" sshEnvPaths;
in
{
  programs.ssh = {
    enable = true;

    # Disable the legacy defaults so we have full control;
    # the values we actually want are in the "*" settings block below.
    enableDefaultConfig = false;

    settings = {
      # ── Global defaults ──────────────────────────────────────────────
      "*" = {
        # ── Connection reliability ──
        # Send a keepalive every 60 s to detect dead peers early.
        # (0 = disabled, which is the upstream default.)
        ServerAliveInterval = 60;
        # Drop the connection after 3 consecutive missed keepalives
        # (60 s × 3 = 180 s before a stuck connection is torn down).
        ServerAliveCountMax = 3;

        # ── Connection multiplexing ──
        # Reuse an existing TCP connection for successive SSH sessions
        # to the same host — eliminates the handshake latency on
        # subsequent invocations.
        ControlMaster = "auto";
        ControlPath = "\${XDG_RUNTIME_DIR}/ssh/master-%r@%n:%p";
        # Keep the control socket alive for 10 minutes after the last
        # session closes so short bursts of activity reuse the socket.
        ControlPersist = "600";

        # ── Key management ──
        # Automatically add keys to the agent on first use so we don't
        # have to run ssh-add manually.
        AddKeysToAgent = "yes";
        # Disable agent forwarding by default; re-enable per-host only
        # when needed to limit exposure of the local agent.
        ForwardAgent = false;

        # ── Security ──
        # Hash hostnames in known_hosts so a reader can't tell which
        # hosts you connect to.
        HashKnownHosts = true;
        # Use XDG-conformant location for known_hosts.
        UserKnownHostsFile = "\${XDG_DATA_HOME}/ssh/known_hosts";

        # ── Performance ──
        # Enable compression; helps on slow / high-latency links and
        # costs almost nothing on modern fast networks.
        Compression = true;
      };
    };

    # Include additional config snippets that live outside Nix control
    # (e.g. work-specific overrides, dynamic jumps).
    includes = [ "config.d/*" ];
  };

  # Ensure the directories referenced by programs.ssh exist.
  # XDG_DATA_HOME/ssh for known_hosts, XDG_RUNTIME_DIR/ssh for
  # control sockets (the latter is on tmpfs and wiped on reboot so
  # systemd-tmpfiles recreates it each session).
  xdg.dataFile."ssh/.keep".text = "";
  systemd.user.tmpfiles.rules = [
    "d %t/ssh 0700 - - -"
  ];

  # ── sshd environment file ──────────────────────────────────────
  # Provides PATH to non-interactive RemoteCommand invocations
  # (e.g. `zmx attach %k` from Termux) which otherwise get sshd's
  # bare default PATH with no nix or user-local directories.
  # Built from config.home.sessionPath + stable nix/system paths.
  home.file.".ssh/environment".text = ''
    PATH=${sshEnvPath}
  '';
}