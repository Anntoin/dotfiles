{ pkgs, ... }:
# File tools
{
  home.packages = with pkgs; [
    ripgrep
    dasel
    ouch
    pandoc
  ];
}
