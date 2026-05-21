{ pkgs, ... }:
# Developer tools
{
  home.packages = with pkgs; [
    devenv
    lazygit # Fallback TUI git client which supports staging lines
    nil # Language server for Nix
    nixd # Another language server for Nix :p
    nixfmt # Official formatter
    opentofu
    duckdb
    dbeaver-bin
    awscli2
    mqttui
    mqttx
    regex-tui
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "Anntóin Wilkinson";
      user.email = "anntoin@gmail.com";
      alias.lol = "log --graph --decorate --oneline";
    };
  };
}
