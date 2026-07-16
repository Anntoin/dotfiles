{ pkgs, ... }:
# Fish shell configuration
{
  programs.fish = {
    enable = true;
    generateCompletions = true;
    shellAbbrs = {
      # Colourise help for commands
      "-h" = {
        position = "anywhere";
        expansion = "-h | bat -p -l help --paging 'never'";
      };
      "--help" = {
        position = "anywhere";
        expansion = "--help | bat -p -l help --paging 'never'";
      };
    };

    plugins = [
      # {
      #   name = "fish-helix";
      #   src = pkgs.fishPlugins.fish-helix.src;
      # }
      {
        name = "fishbang";
        src = pkgs.fishPlugins.fishbang.src;
      }
      {
        name = "you-should-use";
        src = pkgs.fishPlugins.fish-you-should-use.src;
      }
      {
        name = "pisces";
        src = pkgs.fishPlugins.pisces.src;
      }
    ];

    # TODO: add magic enter

    shellInit = ''
      set -U fish_greeting
    '';

    interactiveShellInit = ''
      fish_vi_key_bindings

      # Atuin and Starship should always be present
      atuin hex init fish | source
      atuin init fish | source
      starship init fish | source

      # Conditionaly load Devenv
      if command -q devenv
        devenv hook fish | source
      end

      # Not compatible with home-managers automatic plugin sourcing
      source ~/.config/fish/conf.d/plugin-pisces.fish
    '';
  };

  # Shell securiry:
  # https://tirith.sh/
  programs.tirith = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };
}