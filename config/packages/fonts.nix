{ pkgs, ...}:
{
  home.packages = with pkgs; [
    # Using nerdfont patched varieties of the following fonts
    # https://www.nerdfonts.com/

    # Lilex, developer font based on IBM Plex Mono
    # https://lilex.myrt.co/
    nerd-fonts.lilex

    # Noto, fallback for no tofu
    # https://fonts.google.com/noto
    nerd-fonts.noto
  ];

  fonts.fontconfig.enable = true;
}
