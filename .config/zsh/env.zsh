export PYENV_ROOT="$HOME/.pyenv"
# Shims are only needed when pyenv actually manages a version; the full
# `pyenv init` (slow, spawns shims + completions) runs lazily on first use.
if [ -d "$PYENV_ROOT/versions" ] && [ -z "$(ls -A "$PYENV_ROOT/versions" 2>/dev/null)" ]; then
  : # no versions installed -> skip pyenv entirely
else
  eval "$(pyenv init --path 2>/dev/null)"
fi
pyenv() {
  # First real use: load the full init once, then run the command.
  unset -f pyenv
  eval "$(command pyenv init - 2>/dev/null)"
  command pyenv "$@"
}

# PATH entries (kept first occurrence, rest appended only if missing)…
for p in "$HOME/.local/bin" "$HOME/.npm-global/bin" "$HOME/go/bin" "$HOME/.pyenv/bin" "/usr/sbin" "$HOME/Android/Sdk/platform-tools"; do
  case ":$PATH:" in
    *":$p:"*) ;;
    *) export PATH="$p:$PATH" ;;
  esac
done
unset p
# …and finally drop any duplicates others (/etc/zsh/*, plugins) introduced.
# typeset -U keeps the FIRST occurrence of each entry, order preserved.
typeset -U PATH path
