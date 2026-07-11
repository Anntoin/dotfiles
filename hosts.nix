let
  defaultModules = [
    ./config/home-manager.nix
    ./config/shell.nix
    ./config/fonts.nix
  ];

  desktopModules = [
    ./config/editor.nix
    ./config/terminal.nix
    ./config/dev-tools.nix
    ./config/admin-tools.nix
    ./config/file-tools.nix
    ./config/desktop-tools.nix
    ./config/clipcat.nix
    ./config/keymapper.nix
  ]
  ++ defaultModules;

  serverModules = [
    ./config/editor.nix
    ./config/admin-tools.nix
    ./config/file-tools.nix
  ]
  ++ defaultModules;

  # Host specific configuration
  hostConfig = {
    "manuzio" = {
      hostname = "manuzio";
      modules = desktopModules ++ [
        ./config/productivity-tools.nix
        ./config/sdr-tools.nix
      ];
    };
    "abulafia" = {
      hostname = "abulafia";
      modules = desktopModules;
    };
    "garamond" = {
      hostname = "garamond";
      modules = serverModules;
    };
    "pilades" = {
      hostname = "pilades";
      modules = serverModules;
    };
  };
in
{
  getHostConfig = hostname: hostConfig.${hostname};
}
