let
  # Host-specific extra modules (beyond the profile baseline)
  hostConfig = {
    "manuzio" = {
      hostname = "manuzio";
      profile = "desktop";
      extraModules = [
        ./config/productivity/default.nix
        ./config/sdr/default.nix
      ];
    };
    "abulafia" = {
      hostname = "abulafia";
      profile = "desktop";
      extraModules = [ ];
    };
    "garamond" = {
      hostname = "garamond";
      profile = "server";
      extraModules = [ ];
    };
    "pilades" = {
      hostname = "pilades";
      profile = "server";
      extraModules = [ ];
    };
  };

  profileModules = {
    desktop = ./config/profiles/desktop.nix;
    server = ./config/profiles/server.nix;
  };
in
{
  getHostConfig = hostname:
    let cfg = hostConfig.${hostname};
    in cfg // {
      modules = [ profileModules.${cfg.profile} ] ++ cfg.extraModules;
    };
}