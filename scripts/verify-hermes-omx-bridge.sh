#!/usr/bin/env bash
set -euo pipefail

INSTALL=0
RUN_OMX_SMOKE=0
SKILL_ID="devswha/hermes-omx-bridge-skill/skills/hermes-omx-bridge"
TAP_REPO="devswha/hermes-omx-bridge-skill"

usage() {
  cat <<USAGE
Usage: $0 [--install] [--omx-smoke]

Checks Hermes ↔ OMX bridge prerequisites and skill discovery.

Options:
  --install     Install the Hermes skill if inspection succeeds.
  --omx-smoke   Run a disposable omx explore smoke test.
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --install) INSTALL=1 ;;
    --omx-smoke) RUN_OMX_SMOKE=1 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown argument: $1" >&2; usage >&2; exit 2 ;;
  esac
  shift
done

check_cmd() {
  local cmd="$1"
  if command -v "$cmd" >/dev/null 2>&1; then
    printf 'ok: %s -> %s\n' "$cmd" "$(command -v "$cmd")"
  else
    printf 'missing: %s\n' "$cmd" >&2
    return 1
  fi
}

check_cmd git
check_cmd hermes
check_cmd omx
if command -v gh >/dev/null 2>&1; then
  printf 'ok: gh -> %s\n' "$(command -v gh)"
  gh auth status >/dev/null 2>&1 && echo 'ok: gh authenticated' || echo 'warn: gh is installed but not authenticated'
else
  echo 'warn: gh not installed; public GitHub skill fetch may still work through Hermes'
fi

echo '--- tap registration ---'
hermes skills tap add "$TAP_REPO" || true
hermes skills tap list || true

echo '--- skill inspect ---'
hermes skills inspect "$SKILL_ID" >/tmp/hermes-omx-bridge-inspect.txt
sed -n '1,80p' /tmp/hermes-omx-bridge-inspect.txt

if [[ "$INSTALL" -eq 1 ]]; then
  echo '--- skill install ---'
  hermes skills install "$SKILL_ID" --yes
fi

if [[ "$RUN_OMX_SMOKE" -eq 1 ]]; then
  echo '--- omx disposable smoke ---'
  tmpdir="$(mktemp -d /tmp/hermes-omx-bridge-smoke.XXXXXX)"
  (
    cd "$tmpdir"
    git init -q
    printf '# Hermes OMX bridge smoke\n' > README.md
    git add README.md && git commit -qm init
    omx explore --prompt 'Read-only smoke test: confirm README.md exists in this disposable repo. Do not edit files.'
  )
  echo "ok: omx smoke completed in $tmpdir"
fi

echo 'ok: Hermes OMX bridge verification completed'
