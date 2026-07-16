let
  # Host-specific extra modules (beyond the topic baseline)
  hostConfig = {
    "manuzio" = {
      hostname = "manuzio";
      topic = "desktop";
      extraModules = [
        ./config/packages/productivity-tools.nix
        ./config/packages/sdr-tools.nix
      ];
    };
    "abulafia" = {
      hostname = "abulafia";
      topic = "desktop";
      extraModules = [ ];
    };
    "garamond" = {
      hostname = "garamond";
      topic = "server";
      extraModules = [ ];
    };
    "pilades" = {
      hostname = "pilades";
      topic = "server";
      extraModules = [ ];
    };
  };

  topicModules = {
    desktop = ./config/topics/desktop.nix;
    server = ./config/topics/server.nix;
  };
in
{
  getHostConfig = hostname:
    let cfg = hostConfig.${hostname};
    in cfg // {
      modules = [ topicModules.${cfg.topic} ] ++ cfg.extraModules;
    };
}