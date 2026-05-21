{ pkgs, ... }:
# Productivity tools
{
  home.packages = with pkgs; [
    joplin-desktop
    joplin-cli
  ];
}
