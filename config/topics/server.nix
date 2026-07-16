# Server baseline — modules common to all server hosts
{
  imports = [
    ./base.nix
    ../programs/editor/default.nix
    ../packages/admin-tools.nix
    ../packages/file-tools.nix
  ];
}