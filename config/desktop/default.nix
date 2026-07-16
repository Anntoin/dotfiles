# Desktop environment — compositor, terminal, input, clipboard
{
  imports = [
    ./sway/default.nix
    ./keymapper/default.nix
    ./clipcat.nix
    ./terminal.nix
    ./tools.nix
  ];
}