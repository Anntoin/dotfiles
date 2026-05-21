{ pkgs, ... }:
# Desktop stuff
{
  home.packages = with pkgs; [
    tofi
    fuzzel
  ];

  services.wayle = {
    enable = true;
  };
}
