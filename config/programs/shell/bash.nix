{ pkgs, ... }:
# Bash + readline configuration
#
# Readline is configured with helix-inspired vi-mode keybindings.
# See design notes in the readline section below.
{
  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellOptions = [
      # Append to history file rather than replacing
      # We should have atuin available generally so this is just a fallback
      "histappend"
      # Check window size after each command
      "checkwinsize"
      # Autocorrect minor typos in cd
      "cdspell"
      # Extended globbing
      "extglob"
      # Enable ** globbing
      "globstar"
    ];

    historyControl = [
      "ignoredups"
      "erasedups"
    ];

    historyFileSize = 100000;
    historySize = 100000;

    initExtra = ''
      ${builtins.readFile ./scripts/quick-source.sh}

      # Conditionally load Devenv
      if command -v devenv >/dev/null 2>&1; then
        eval "$(devenv hook bash)"
      fi

      # Tirith enter mode
      # Mode (bind -x) doesn't work reliably in bash because bind -x doesn't
      # trigger PROMPT_COMMAND, so commands get silently swallowed. Use preexec
      # mode for bash instead; fish is unaffected.
      # https://github.com/sheeki03/tirith/pull/24
      TIRITH_BASH_MODE="preexec"

      # Suppress tirith preexec banner
      # We intentionally use preexec mode; suppress the "warn-only" notice.
      _TIRITH_PREEXEC_WARNED=1

      # ── Cached shell integrations ──
      # bash-preexec must be sourced before atuin
      if [[ :$SHELLOPTS: =~ :(vi|emacs): ]]; then
        source "${pkgs.bash-preexec}/share/bash/bash-preexec.sh"
      fi

      _quick_source atuin atuin init bash

      if [[ $TERM != "dumb" ]]; then
        _quick_source starship starship init bash --print-full-init
      fi

      _quick_source zoxide zoxide init bash
    '';
  };

  # Readline — helix-inspired vi-mode keybindings
  #
  # Design notes:
  #   • Readline only supports single-function bindings per key sequence.
  #     There is no way to chain "delete then switch to insert mode", so
  #     change operators (cw, cc, s) delete but stay in command mode.
  #     Press i/a afterwards to re-enter insert mode.
  #   • yy kills the line (deletes it) and puts it in the kill ring.
  #     This is a readline limitation — there is no "copy line without
  #     killing" function. Paste with p to recover the line.
  #   • Visual selection is not possible — readline's active region highlighting
  #     only works for bracketed paste and incremental search, not for
  #     continuous mark-to-point selection. set-mark still works for kill-region
  #     operations (Ctrl-W), just without visual feedback.
  #   • Only 2-key sequences are used; 3-key combos (like vdw) are not
  #     supported because readline can't chain commands.
  #
  programs.readline = {
    enable = true;
    includeSystemConfig = false;

    # NOTE: Bindings are in extraConfig rather than the `bindings` attr
    # because Nix string escaping mangles the readline escape sequences
    # (\t becomes a literal tab, \e loses its backslash).
    extraConfig = ''
      # Cursor shape by mode
      $if term=linux
        set vi-ins-mode-string \1\e[?0c\2
        set vi-cmd-mode-string \1\e[?8c\2
      $else
        set vi-ins-mode-string \1\e[6 q\2
        set vi-cmd-mode-string \1\e[2 q\2
      $endif

      # Active region highlighting
      set active-region-start-color \e[48;2;81;87;109m
      set active-region-end-color   \e[49m

      # Vi-mode specific bindings
      $if mode=vi
        # Default to insert mode on new prompts
        set keymap vi-insert

        # Command-mode keymap
        set keymap vi-command

        # Motions
        h:         backward-char
        l:         forward-char
        j:         next-screen-line
        k:         previous-screen-line
        w:         forward-word
        b:         backward-word
        f:         character-search
        F:         character-search-backward
        Home:      beginning-of-line
        End:       end-of-line

        # Copy/Paste/Delete
        # (motion-first, helix-style: select then operate)
        # NOTE: w/b/e now start 2-key sequences, causing a brief timeout
        # before the single-key motion fires. keyseq-timeout minimises this
        # in Bash; other readline programs may feel slower on w/b/e.
        d:         delete-char
        "wd":      kill-word
        "bd":      backward-kill-word
        "xd":      kill-whole-line
        p:         yank # i.e. paste

        # Undo
        u:         undo
      $endif

      # Keyseq timeout sufficient for 2-key sequences
      $if Bash
        set keyseq-timeout 100
      $endif
    '';

    variables = {
      editing-mode = "vi";
      keymap = "vi-insert";
      show-mode-in-prompt = "on";
      completion-ignore-case = "on";
      colored-completion-prefix = "on";
      menu-complete-display-prefix = "on";
      show-all-if-unmodified = "on";
      visible-stats = "on";
      colored-stats = "on";
      mark-symlinked-directories = "on";
      enable-active-region = "on";
    };
  };
}