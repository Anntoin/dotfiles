{ ... }:
# Shared shell history:
# https://atuin.sh/
{
  programs.atuin = {
    enable = true;
    enableBashIntegration = false; # handled by _quick_source in bash initExtra
    enableFishIntegration = true;
    daemon.enable = true;
    settings = {
      dialet = "uk";
      auto_sync = true;
      show_help = false;
      show_tabs = false;
      sync_frequency = "5m";
      sync_address = "https://history.anntoin.com";
      search_mode = "fuzzy";
      inline_height = 3;
      enter_accept = true;
      keymap_mode = "auto";
      keymap_cursor = {
        emacs = "steady-block";
        vim_insert = "blink-bar";
        vim_normal = "blink-block";
      };
    };
  };
}