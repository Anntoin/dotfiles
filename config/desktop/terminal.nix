{ ... }:
# Graphical terminal(s)
{
  # Fast, featureful terminal:
  # https://sw.kovidgoyal.net/kitty/
  programs.kitty = {
    enable = true;
    # Should be enabled by default but no harm being explicit
    shellIntegration = {
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
    # quickAccessTerminalConfig = {};
    # enableGitIntegration = true;
    settings = {
      shell = "fish";
      enable_audio_bell = "no";
      scrollback_pager = "moor";
      share_connections = "yes";
      show_hyperlink_targets = "no";
      focus_follows_mouse = "yes";
      kitty_mod = "ctrl+shift"; # TODO: might update default
    };
    autoThemeFiles = {
      dark = "Catppuccin-Frappe";
      light = "Catppuccin-Latte";
      noPreference = "Catppuccin-Frappe";
    };
    font = {
      name = "Lilex Nerd Font Mono";
      size = 14;
    };
  };

}
