{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bleachbit
    trippy
    lnav
    drill
    prettyping
    wireshark
  ];

  # A monitor of resources
  # https://github.com/aristocratos/btop
  programs.btop = {
    enable = true;
    settings = {
      vim_keys = "true";
    };
  };
}
