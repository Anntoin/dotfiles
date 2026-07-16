# Base modules shared by all hosts (desktop and server)
{
  imports = [
    ../programs/home-manager/default.nix
    ../programs/shell/default.nix
    ../packages/fonts.nix
  ];
}