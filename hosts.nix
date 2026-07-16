let
  # Base modules shared by all hosts
  baseModules = [
    ./config/home-manager.nix
    ./config/shell/default.nix
    ./config/fonts/default.nix
  ];

  # Desktop baseline — common to all desktop hosts
  desktopModules = baseModules ++ [
    ./config/editor/default.nix
    ./config/desktop/default.nix
    ./config/dev/default.nix
    ./config/admin/default.nix
    ./config/files/default.nix
  ];

  # Server baseline — common to all server hosts
  serverModules = baseModules ++ [
    ./config/editor/default.nix
    ./config/admin/default.nix
    ./config/files/default.nix
  ];

  hostConfig = {
    "manuzio" = {
      hostname = "manuzio";
      modules = desktopModules ++ [
        ./config/productivity/default.nix
        ./config/sdr/default.nix
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