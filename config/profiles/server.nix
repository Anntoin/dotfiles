# Server profile — base + editor, admin, file tools
{
  imports = [
    ./base.nix
    ../editor/default.nix
    ../admin/default.nix
    ../files/default.nix
  ];
}