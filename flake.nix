{
  description = "Anntóins Home Manager Configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      # Get any host specific configuration
      # Now just passing the hostname through but can use this later
      # for more detailed configurations while still keeping purity
      getHostConfig = hostname: { inherit hostname; };

      # Set up home-manager with the given host configuration
      mkHost =
        hostConfig:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            ./config/home-manager.nix
            ./config/shell.nix
            ./config/editor.nix
            ./config/terminal.nix
            ./config/dev-tools.nix
            ./config/admin-tools.nix
            ./config/file-tools.nix
          ];

          extraSpecialArgs = { inherit hostConfig; };
        };
    in
    {
      # configuration is selected automatically based on your
      # username & hostname, see `man home-manager`
      homeConfigurations = {
        "anntoin@manuzio" = mkHost (getHostConfig "manuzio");
        "anntoin@garamond" = mkHost (getHostConfig "garamond");
        "anntoin@abulafia" = mkHost (getHostConfig "abulafia");
        "anntoin@pilades" = mkHost (getHostConfig "pilades");
      };
    };
}
