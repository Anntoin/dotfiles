# Base profile — modules shared by all hosts
{
  imports = [
    ../home-manager.nix
    ../shell/default.nix
    ../fonts/default.nix
  ];
}