{
  description = "Anntóins Home Manager Configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hermes-agent = {
      url = "github:NousResearch/hermes-agent";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Override keymapper for testing
    nixpkgs-keymapper.url = "github:NixOS/nixpkgs/refs/pull/555405/head";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-keymapper,
      home-manager,
      hermes-agent,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            keymapper = nixpkgs-keymapper.legacyPackages.${system}.keymapper;
          })
        ];
      };

      # Per-host configs
      hosts = import ./hosts.nix;

      # Set up home-manager with the given host configuration
      mkHost =
        hostConfig:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = hostConfig.modules;
          extraSpecialArgs = {
            inherit hostConfig;
            hermesPkg = hermes-agent.packages.${system}.minimal;
          };
        };
    in
    {
      # configuration is selected automatically based on your
      # username & hostname, see `man home-manager`
      homeConfigurations = {
        "anntoin@manuzio" = mkHost (hosts.getHostConfig "manuzio");
        "anntoin@garamond" = mkHost (hosts.getHostConfig "garamond");
        "anntoin@abulafia" = mkHost (hosts.getHostConfig "abulafia");
        "anntoin@pilades" = mkHost (hosts.getHostConfig "pilades");
      };
    };
}
