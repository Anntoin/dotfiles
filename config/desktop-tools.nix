{ pkgs, lib, ... }:
# Desktop stuff
{
  home.packages = with pkgs; [
    fuzzel
    jq
  ]
  ++ [
    # OpenProject CLI — prebuilt Go binary (flake build broken: Go version mismatch)
    # https://github.com/opf/openproject-cli/releases
    (pkgs.stdenv.mkDerivation rec {
      pname = "openproject-cli";
      version = "0.5.5";
      src = pkgs.fetchzip {
        url = "https://github.com/opf/openproject-cli/releases/download/v${version}/openproject-cli_linux_amd64_v${version}.zip";
        sha256 = "wZBoKJNUFtdU8cTz1VLEe2xsGuv3cjgtSywe3982Cm4=";
        stripRoot = false;
      };
      installPhase = ''
        runHook preInstall
        install -Dm755 op $out/bin/op
        runHook postInstall
      '';
      meta = with lib; {
        description = "CLI for the OpenProject APIv3";
        homepage = "https://github.com/opf/openproject-cli";
        license = licenses.gpl3Only;
        platforms = [ "x86_64-linux" ];
      };
    })
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

  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "text/html" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "x-scheme-handler/about" = [ "firefox.desktop" ];
      "x-scheme-handler/unknown" = [ "firefox.desktop" ];
      "x-scheme-handler/readest" = [ "Readest-handler.desktop" ];
      "x-scheme-handler/joplin" = [ "joplin.desktop" ];
    };
    defaultApplications = {
      "text/html" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "x-scheme-handler/about" = [ "firefox.desktop" ];
      "x-scheme-handler/unknown" = [ "firefox.desktop" ];
      "x-scheme-handler/readest" = [ "Readest-handler.desktop" ];
      "x-scheme-handler/joplin" = [ "joplin.desktop" ];
    };
  };
}
