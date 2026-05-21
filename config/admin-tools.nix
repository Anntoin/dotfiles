{ pkgs, ... }:
{
  home.packages = with pkgs; [
    btop
    trippy
    lnav
    drill
    prettyping
    wireshark
  ];
}
