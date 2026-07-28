{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bleachbit
    trippy
    lnav
    drill
    prettyping
    wireshark
    # Hardware diagnostics
    ethtool
    smartmontools
    pciutils # lspci
    usbutils # lsusb
    dmidecode
    # Performance monitoring
    sysstat # iostat, mpstat, sar
    bandwhich # per-process network usage
    dust # du replacement
    lsof
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
