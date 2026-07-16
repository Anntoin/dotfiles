# ── Fast shell init: cache eval-heavy integrations ──────────────────
#
# The eval "$(cmd init)" pattern forks a subprocess and forces bash to
# parse the entire output as a string on every start, costing ~5 s.
# Caching the generated scripts and source-ing them instead drops this
# to <1 s.
#
# Cache invalidation:
#   The marker file stores the resolved binary path AND the init flags.
#   A cache miss is triggered when either changes, so:
#     ✅ Binary updates  — nix store path changes → cache invalidated
#     ✅ Flag changes     — e.g. atuin --disable-ctrl-r → cache invalidated
#     ✅ Version changes — new binary → new store path → cache invalidated
#
# Known gaps:
#     ⚠  If a tool's "init" output ever depends on a config file
#        (e.g. ~/.config/atuin/config.toml) rather than just its flags
#        and its binary, the cache won't catch that.  Manually clear with
#        `rm -rf ~/.cache/shell-init/` if you suspect stale output.
#
#     ⚠  The init scripts themselves are assumed to be deterministic
#        for a given binary + flags.  This holds for atuin, starship,
#        and zoxide today — they produce static function definitions
#        and keybindings, reading config at runtime, not at init time.
#

# Cache directory for generated init scripts and their marker files.
_cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/shell-init"
mkdir -p "$_cache_dir"

# _quick_source — cache and source a shell init script
#
# Usage: _quick_source <name> <cmd> [args...]
#
#   name    Unique key used for the cache filenames (e.g. "atuin").
#   cmd     The command that generates the init script (e.g. "atuin").
#   args    Arguments passed through to the command (e.g. "init bash").
#
# On first run (or after a binary/flag change), this runs the command,
# writes the output to ~/.cache/shell-init/<name>.sh, and sources it.
# On subsequent runs it skips the subprocess and sources the cached
# file directly — that's the speed win.
#
# If the command is not found on PATH, the function returns 0 silently
# so missing tools don't break the shell.
#
_quick_source() {
  local name="$1" cmd="$2"
  shift 2

  # Cache file: the generated init script written by the tool.
  local cache="$_cache_dir/$name.sh"

  # Marker file: stores "<resolved-binary-path> <flags>" to detect when
  # the cache is stale.  Comparing the resolved symlink target means a
  # nix update (new /nix/store/... path) invalidates the cache even
  # though the wrapper script name (e.g. "atuin") hasn't changed.
  local marker="$_cache_dir/$name.marker"

  # Resolve the command to its real path.  If it's not on PATH, the
  # tool isn't installed — return 0 so the shell continues cleanly.
  local bin
  bin="$(command -v "$cmd" 2>/dev/null)" || return 0
  local real_path
  real_path="$(readlink -f "$bin")"

  # Build the marker value from the resolved path plus all remaining
  # arguments.  This means changing e.g. "init bash" to "init bash
  # --disable-ctrl-r" will trigger a cache rebuild even though the
  # binary path hasn't changed.
  local marker_value="$real_path $*"

  # Rebuild the cache if it doesn't exist or if the marker doesn't
  # match (binary updated or flags changed).
  if [ ! -f "$cache" ] || [ "$(cat "$marker" 2>/dev/null)" != "$marker_value" ]; then
    # Run the init command and write the output to the cache file.
    # If the command fails, clean up the stale cache and return 1 so
    # the caller can notice (though typically we just continue).
    "$cmd" "$@" > "$cache" 2>/dev/null || { rm -f "$cache"; return 1; }
    printf '%s' "$marker_value" > "$marker"
  fi

  # Source the (now-valid) cached init script.
  source "$cache"
}