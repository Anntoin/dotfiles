{
  pkgs,
  config,
  hostConfig,
  ...
}:
# Core shell environment and tools
{

  home.packages = with pkgs; [
    # Nice pager:
    # https://github.com/walles/moor
    moor

    # Concise help pages:
    # https://tldr.sh/
    tldr

    # CLI for bitwarden
    # https://github.com/doy/rbw
    rbw
  ];

  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "zeditor";
    PAGER = "moor";
    SHELL = "fish";

    # Disable default linenumbers, can be toggled with <- key
    # Disable paging when content will fit in the screen
    MOOR = "--no-linenumbers --quit-if-one-screen";

    # Set to avoid using VISUAL and use absolute path as hx is provided by home-manager
    SUDO_EDITOR = "$(which hx)";

    # Make systemd respect PAGER
    SYSTEMD_PAGERSECURE = true;

    # bat uses PAGER ust provides the highlighting
    MANPAGER = "bat -p -lman";

    # ZMX Prefix
    ZMX_SESSION_PREFIX = "${hostConfig.hostname}.";

    # Prefer EDITOR for git
    GIT_EDITOR = "$EDITOR";

    # SSH agent
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/rbw/ssh-agent-socket";
  };

  home.shellAliases = {
    "ls" = "eza --hyperlink";
    "info" = "info --vi-keys";
  };

  # SSH client configuration
  # https://linux.die.net/man/5/ssh_config
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

  # Nice interactive shell:
  # https://fishshell.com/
  programs.fish = {
    enable = true;
    generateCompletions = true;
    shellAbbrs = {
      # Colourise help for commands
      "-h" = {
        position = "anywhere";
        expansion = "-h | bat -p -l help --paging 'never'";
      };
      "--help" = {
        position = "anywhere";
        expansion = "--help | bat -p -l help --paging 'never'";
      };
    };

    plugins = [
      # {
      #   name = "fish-helix";
      #   src = pkgs.fishPlugins.fish-helix.src;
      # }
      {
        name = "fishbang";
        src = pkgs.fishPlugins.fishbang.src;
      }
      {
        name = "you-should-use";
        src = pkgs.fishPlugins.fish-you-should-use.src;
      }
      {
        name = "pisces";
        src = pkgs.fishPlugins.pisces.src;
      }
    ];

    # TODO: add magic enter

    shellInit = ''
      set -U fish_greeting
    '';

    interactiveShellInit = ''
      fish_vi_key_bindings

      # Atuin and Starship should always be present
      atuin hex init fish | source
      atuin init fish | source
      starship init fish | source

      # Conditionaly load Devenv
      if command -q devenv
        devenv hook fish | source
      end

      # Not compatible with home-managers automatic plugin sourcing
      source ~/.config/fish/conf.d/plugin-pisces.fish
    '';
  };

  # Shell securiry:
  # https://tirith.sh/
  programs.tirith = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };

  # Shared history:
  # https://atuin.sh/
  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    daemon.enable = true;
    settings = {
      dialet = "uk";
      auto_sync = true;
      show_help = false;
      show_tabs = false;
      sync_frequency = "5m";
      sync_address = "https://history.anntoin.com";
      search_mode = "fuzzy";
      inline_height = 3;
      enter_accept = true;
      keymap_mode = "auto";
      keymap_cursor = {
        emacs = "steady-block";
        vim_insert = "blink-bar";
        vim_normal = "blink-block";
      };
    };
  };

  # Fancy Prompt:
  # https://starship.rs/
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    configPath = "${config.xdg.configHome}/starship/starship.toml";
  };
  xdg.configFile."starship" = {
    recursive = true;
    source = ./starship;
  };

  # Cat replacement with syntax highlighting:
  # https://github.com/sharkdp/bat
  programs.bat = {
    enable = true;
    config = {
      theme = "Catppuccin Frappe";
    };
  };

  # Directory navigation:
  # https://github.com/ajeetdsouza/zoxide
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };

  # Generate LS_COLORS:
  # https://github.com/sharkdp/vivid
  programs.vivid = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    activeTheme = "catppuccin-frappe";
  };

  # Fuzzy finder with 'channel' interface:
  # https://alexpasmantier.github.io/television/
  programs.television = {
    enable = true;
    settings = {
      theme = "catppuccin";
      previewers.file.theme = "Catppuccin Frappe"; # Needed?
      # TODO: Refine channels
    };
  };
  xdg.configFile."television" = {
    source = ./television;
    recursive = true;
  };

  # Nix fuzzy search provider:
  # https://github.com/3timeslazy/nix-search-tv
  programs.nix-search-tv = {
    enable = true;
    enableTelevisionIntegration = true;
  };

  # Update tldr sources automatically
  services.tldr-update = {
    enable = true;
    period = "weekly";
  };

  # Ranger-like file manager:
  # https://yazi-rs.github.io/
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    shellWrapperName = "y";

    plugins = {
      yatline = pkgs.yaziPlugins.yatline;
      full-border = pkgs.yaziPlugins.full-border;
      vcs-files = pkgs.yaziPlugins.vcs-files;
      ouch = pkgs.yaziPlugins.ouch;
      duckdb = pkgs.yaziPlugins.duckdb;
      # nbpreview = "${yazi-plugins}/nbpreview.yazi";
    };
  };
  xdg.configFile."yazi" = {
    source = ./yazi;
    recursive = true;
  };
}
