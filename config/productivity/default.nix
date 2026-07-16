{ pkgs, ... }:
# Productivity tools
{
  home.packages = with pkgs; [
    joplin-desktop
    joplin-cli
  ];

  # Is email productive?
  programs.thunderbird = {
    enable = true;
    languagePacks = [ "en-GB" ];
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
