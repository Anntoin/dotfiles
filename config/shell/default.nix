{
  pkgs,
  hostConfig,
  hermesPkg,
  ...
}:
# Core shell environment — session vars, packages, aliases.
# Sub-modules handle individual programs (bash, fish, atuin, etc.)
{
  imports = [
    ./bash.nix
    ./fish.nix
    ./rbw.nix
    ./ssh.nix
    ./atuin.nix
    ./starship.nix
    ./tools.nix
    ./television.nix
    ./hermes-skills.nix
  ];

  home.packages = with pkgs; [
    # Nice pager:
    # https://github.com/walles/moor
    moor

    # Concise help pages:
    # https://tldr.sh/
    tldr

    # AI agent framework by Nous Research
    # https://github.com/NousResearch/hermes-agent
    # Installed via nix flake — includes pre-built TUI (no npm deps needed)
    hermesPkg
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
}