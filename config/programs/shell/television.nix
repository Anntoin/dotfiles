{ ... }:
# Fuzzy finder with 'channel' interface:
# https://alexpasmantier.github.io/television/
{
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
}