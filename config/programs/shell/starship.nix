{
  config,
  hostConfig,
  ...
}:
# Fancy Prompt:
# https://starship.rs/
{
  programs.starship = {
    enable = true;
    enableBashIntegration = false; # handled by _quick_source in bash initExtra
    enableFishIntegration = true;
    configPath = "${config.xdg.configHome}/starship/starship.toml";
  };

  # Generate starship config with hostname-specific styling
  # Maps each host to a catppuccin-frappe accent color, with sapphire as fallback
  xdg.configFile."starship/starship.toml" = {
    text =
      builtins.replaceStrings
        [ "__HOST_COLOR__" ]
        [
          (
            {
              manuzio = "blue";
              garamond = "green";
              pilades = "teal";
              abulafia = "mauve";
            }
            // {
              ${hostConfig.hostname} = "sapphire";
            }
          ).${hostConfig.hostname}
        ]
        (builtins.readFile ./starship.toml);
  };
}