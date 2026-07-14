{ pkgs, ... }:
# Desktop stuff
{
  home.packages = with pkgs; [
    fuzzel
  ];

  programs.tofi = {
    enable = true;
    settings = {
      # Font
      font = "/usr/share/fonts/TTF/LilexNerdFontMono-Regular.ttf";
      font-size = 12;

      # Window Style
      horizontal = "true";
      anchor = "top";
      width = "100%";
      height = 30;

      outline-width = 0;
      border-width = 0;
      min-input-width = 120;
      result-spacing = 30;
      padding-top = 2;
      padding-bottom = 2;
      padding-left = 20;
      padding-right = 00;

      # Text style
      prompt-text = "Run:";
      prompt-padding = 10;

      text-color = "#a5adce";
      background-color = "#303446";

      prompt-color = "#e78284";
      prompt-background-padding = "0, 8";
      prompt-background-corner-radius = 4;

      input-color = "#e5c890";
      input-background-padding = "0, 8";
      input-background-corner-radius = 4;

      selection-color = "#c6d0f5";
      selection-background = "#737994";
      selection-background-padding = "0, 8";
      selection-background-corner-radius = 4;
      selection-match-color = "#e5c890";

      clip-to-padding = false;
    };
  };

  services.wayle = {
    enable = true;
  };
}
