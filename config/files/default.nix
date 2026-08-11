{ pkgs, ... }:
# File tools
{
  home.packages = with pkgs; [
    # very fast grep
    # https://github.com/BurntSushi/ripgrep
    ripgrep

    # Unified querying, transformation, and modification of JSON, TOML, YAML, XML, INI, HCL, KDL and CSV
    # https://daseldocs.tomwright.me/
    dasel

    # Painless compression and decompression in the terminal
    # https://github.com/ouch-org/ouch
    ouch

    # A universal document converter
    # https://pandoc.org/
    pandoc
  ];
}
