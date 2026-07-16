{ ... }:
# Misc CLI tools with minimal configuration
{
  # A simple, fast and user-friendly alternative to 'find'
  # https://github.com/sharkdp/fd
  programs.fd = {
    enable = true;
  };

  # A modern alternative to ls
  # https://github.com/eza-community/eza
  programs.eza = {
    enable = true;
  };

  # Cat replacement with syntax highlighting:
  # https://github.com/sharkdp/bat
  programs.bat = {
    enable = true;
    config = {
      theme = "Catppuccin Frappe";
    };
  };

  # Directory navigation:
  # https://github.com/ajeetdsouza/zoxide
  programs.zoxide = {
    enable = true;
    enableBashIntegration = false; # handled by _quick_source in bash initExtra
    enableFishIntegration = true;
  };

  # Generate LS_COLORS:
  # https://github.com/sharkdp/vivid
  programs.vivid = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    activeTheme = "catppuccin-frappe";
  };

  # Ranger-like file manager:
  # https://github.com/gokcehan/lf
  programs.lf = {
    enable = true;
  };

  # Update tldr sources automatically
  services.tldr-update = {
    enable = true;
    period = "weekly";
  };
}