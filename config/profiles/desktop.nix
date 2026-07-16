# Desktop profile — base + desktop environment, dev tools, admin, files
# Host-specific extras (sdr, productivity, etc.) are added in hosts.nix
{
  imports = [
    ./base.nix
    ../editor/default.nix
    ../desktop/default.nix
    ../dev/default.nix
    ../admin/default.nix
    ../files/default.nix
  ];
}