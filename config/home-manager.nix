{ ... }:
# Configuration for Home Manager itself
{
  # Do not change, see:
  # https://nix-community.github.io/home-manager/index.xhtml#sec-upgrade-release-state-version
  home.stateVersion = "25.11";

  # Basic info
  home.username = "anntoin";
  home.homeDirectory = "/home/anntoin";

  # Enable XDG base directory management
  # Sets XDG_CONFIG_HOME, XDG_DATA_HOME, XDG_CACHE_HOME, XDG_STATE_HOME,
  # and XDG_BIN_HOME as session variables so programs and our own configs
  # can reference them reliably.
  xdg.enable = true;

  # Enable XDG user directories
  # Creates ~/.config/user-dirs.dirs and the standard directories:
  # Desktop, Documents, Downloads, Music, Pictures, Videos, Templates, Public
  xdg.userDirs = {
    enable = true;
    # Export XDG_DESKTOP_DIR, XDG_DOCUMENTS_DIR, etc. as session variables
    # so programs that read env vars (rather than user-dirs.dirs) resolve
    # to the right paths.
    setSessionVariables = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # Automatically update home-manager
  # This will run `home-manager switch --flake .` daily to keep the environment
  # in sync with whatever is in the `flake.lock`. To update the `flake.lock`
  # just manually run `nix flake update` and commit the lock file. Other hosts
  # will get the updates then after they sync with the repo and autoUpgrade runs
  services.home-manager.autoUpgrade = {
    enable = true;
    useFlake = true;
    frequency = "daily";
    # Don't automatically run `nix flake update`
    preSwitchCommands = [ ];
  };
  # Clean up old generations (and the Nix store while we're at it)
  services.home-manager.autoExpire = {
    enable = true;
    frequency = "daily";
    timestamp = "-7 days";
    store.cleanup = true;
  };
  # Include local documentation - man page and options in json format
  manual = {
    manpages.enable = true;
    json.enable = true;
  };
  # Enable GPU support, see:
  #  https://nix-community.github.io/home-manager/index.xhtml#sec-usage-gpu-non-nixos
  targets.genericLinux.gpu.enable = true;
}
