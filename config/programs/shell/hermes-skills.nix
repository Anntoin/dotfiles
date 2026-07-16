{ lib, ... }:
# ── Hermes custom skills symlinks ──────────────────────────────────
# Links ~/.hermes/skills/<category> → ~/resources/skills/<category>
# so that skill edits go directly into the git repo (Anntoin/skills).
# The repo must be cloned first: `gh repo clone Anntoin/skills ~/resources/skills`
{
  home.activation.linkHermesSkills = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    REPO="$HOME/resources/skills"
    HERMES_SKILLS="$HOME/.hermes/skills"

    if [ ! -d "$REPO" ]; then
      verboseEcho "  [hermes-skills] ~/resources/skills not found — run: gh repo clone Anntoin/skills ~/resources/skills"
      exit 0
    fi

    for cat in bat development devops home-manager infrastructure personal-knowledge; do
      src="$REPO/$cat"
      dst="$HERMES_SKILLS/$cat"

      if [ ! -d "$src" ]; then
        continue
      fi

      # Already symlinked correctly
      if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
        continue
      fi

      # Remove existing dir or wrong symlink
      if [ -e "$dst" ] || [ -L "$dst" ]; then
        run rm -rf "$dst"
      fi

      run mkdir -p "$HERMES_SKILLS"
      run ln -s "$src" "$dst"
    done
  '';
}