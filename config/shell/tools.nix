{ config, pkgs, lib, ... }:
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

  # Gate batCache: only rebuild the cache when bat's store path changes.
  # HM's built-in bat module runs `bat cache --build` on every switch;
  # this override skips it when bat hasn't changed, saving ~0.3s.
  home.activation.batCache = lib.hm.dag.entryAfter [ "linkGeneration" ]
    (lib.mkForce ''
    export XDG_CACHE_HOME=${lib.escapeShellArg config.xdg.cacheHome}
    STAMP_FILE="${config.xdg.stateHome}/home-manager/bat-store-path"
    CURRENT_BAT="${lib.getExe config.programs.bat.package}"

    mkdir -p "${config.xdg.stateHome}/home-manager"

    if [ -f "$STAMP_FILE" ] && [ "$(cat "$STAMP_FILE")" = "$CURRENT_BAT" ]; then
      verboseEcho "batCache: skipped (bat unchanged)"
    else
      verboseEcho "Rebuilding bat theme cache"
      cd "${pkgs.emptyDirectory}"
      run ${lib.getExe config.programs.bat.package} cache --build
      echo "$CURRENT_BAT" > "$STAMP_FILE"
    fi
  '');

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