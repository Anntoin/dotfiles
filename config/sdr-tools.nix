{ pkgs, ... }:
# Software defined radio tools
{
  home.packages = with pkgs; [
    sdrangel
  ];
}
