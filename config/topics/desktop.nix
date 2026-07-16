# Desktop baseline — modules common to all desktop hosts
# Host-specific extras (sdr, productivity, etc.) are added in hosts.nix
{
  imports = [
    ./base.nix
    ../programs/editor/default.nix
    ../programs/terminal/default.nix
    ../packages/dev-tools.nix
    ../packages/admin-tools.nix
    ../packages/file-tools.nix
    ../packages/desktop-tools.nix
    ../programs/clipcat/default.nix
    ../programs/keymapper/default.nix
    ../programs/sway/default.nix
  ];
}