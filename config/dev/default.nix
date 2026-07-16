{ pkgs, ... }:
# Developer tools
{
  home.packages = with pkgs; [
    # Nix-based developer environments:
    # https://devenv.sh
    devenv

    # Open fork of terraform:
    # https://opentofu.org/
    opentofu

    # Handy SQL database:
    # https://duckdb.org/
    duckdb

    # DB management tool:
    # https://dbeaver.io
    dbeaver-bin

    # The AWS Cli:
    # https://github.com/aws/aws-cli
    awscli2

    # MQTT terminal interface:
    # https://github.com/EdJoPaTo/mqttui
    mqttui

    # MQTT desktop client:
    # https://mqttx.app
    mqttx

    # Github client:
    # https://cli.github.com/
    github-cli

    # Simple offline regex visualizer
    # https://github.com/vitor-mariano/regex-tui
    regex-tui

    # Bash Automated Testing System
    # https://bats-core.readthedocs.io/en/stable/
    bats

    # Nix stuff
    nil # Language server for Nix
    nixd # Another language server for Nix :p
    nixfmt # Official formatter
  ];

  programs.git = {
    enable = true;
    ignores = [
      ".direnv/"
      ".devenv/"
      "result"
      ".envrc"
      ".env"
      "*.swp"
      "__pycache__/"
      "*.pyc"
      ".mypy_cache/"
      "target/"
    ];
    settings = {
      core.symlinks = true;
      user.name = "Anntóin Wilkinson";
      user.email = "anntoin@gmail.com";
      alias.lol = "log --graph --decorate --oneline";
      alias.uncommit = "reset --soft HEAD~1";
      alias.unpushed = "log @{u}..";
    };
  };

  # Syntax-highlighted diffs with delta
  # https://github.com/dandavison/delta
  # Theme: catppuccin-frappe from https://github.com/catppuccin/delta
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      # Catppuccin Frappe theme (full UI, not just syntax)
      dark = true;
      syntax-theme = "Catppuccin Frappe";
      blame-palette = "#303446 #292c3c #232634 #414559 #51576d";
      commit-decoration-style = "#737994 bold box ul";
      file-decoration-style = "#737994";
      file-style = "#c6d0f5";
      hunk-header-decoration-style = "#737994 box ul";
      hunk-header-file-style = "bold";
      hunk-header-line-number-style = "bold #a5adce";
      hunk-header-style = "file line-number syntax";
      line-numbers = true;
      line-numbers-left-style = "#737994";
      line-numbers-minus-style = "bold #e78284";
      line-numbers-plus-style = "bold #a6d189";
      line-numbers-right-style = "#737994";
      line-numbers-zero-style = "#737994";
      minus-emph-style = "bold syntax #704f5c";
      minus-style = "syntax #544452";
      plus-emph-style = "bold syntax #596b5e";
      plus-style = "syntax #475453";
      zero-style = "syntax";
      map-styles = "bold purple => syntax #66597e, bold blue => syntax #505d81, bold cyan => syntax #546b7a, bold yellow => syntax #6f6860";
      # Behaviour
      navigate = true;
    };
  };

  # TUI git client which supports staging lines:
  # https://github.com/jesseduffield/lazygit
  programs.lazygit = {
    enable = true;
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
    gitCredentialHelper = {
      enable = true;
      hosts = [
        "https://github.com"
        "https://gist.github.com"
      ];
    };
  };
}
