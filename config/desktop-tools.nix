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

  # TODO: only enable on certain machines
  # if desktop:
  programs.thunderbird = {
    enable = true;
    languagePacks = [ "en-GB" ];
    # TODO: add account details
    policies = {
      DisableTelemetry = true;
    };

    settings = {
      mail.biff.play_sound = false;
      mail.threadpane.listview = 1;
      mail.compose.autosaveinterval = 1;
      spellchecker.dictionary = "en-GB";
      mail.SpellCheckBeforeSend = true;
    };
  };
}
