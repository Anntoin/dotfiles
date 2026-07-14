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
    settings = {
      user.name = "Anntóin Wilkinson";
      user.email = "anntoin@gmail.com";
      alias.lol = "log --graph --decorate --oneline";
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
  };
}
