# Hermes OMX Bridge Skill

A Hermes Agent skill that teaches Hermes bots/profiles how to delegate coding, repository analysis, test/fix loops, and parallel execution to [oh-my-codex](https://github.com/devswha/oh-my-codex) via `omx`.

## What it does

This skill lets a user ask a chosen Hermes bot/profile to use OMX. Hermes remains the conversational orchestration layer while `omx` handles code execution:

- `omx explore` for read-only repo lookup
- `omx exec` for implementation, debugging, refactoring, and tests
- `omx ralph` for persistent acceptance-criteria loops
- `omx team` for independent parallel execution lanes
- explicit `omx exec` or `omx ralph` prompts for QA/test/fix cycles

The skill emphasizes scoped prompts, local repo instructions, verification after OMX returns, and safe reporting back to the user.

Typical user request:

```text
Ask <bot-or-profile-name> to use OMX for <goal>.
Repository: <repo-path>
Acceptance: <tests, behavior, docs, or report expected>
```

## Repository layout

```text
helpers/
└── codex-omx-hermes-integration.md
scripts/
└── verify-hermes-omx-bridge.sh
skills/
└── hermes-omx-bridge/
    └── SKILL.md
```

This layout is compatible with Hermes custom GitHub taps, whose default tap path is `skills/`.

## Install from a custom tap

After this repository is pushed to GitHub:

```bash
hermes skills tap add <owner>/<repo>
hermes skills search hermes-omx-bridge
hermes skills install <owner>/<repo>/skills/hermes-omx-bridge
```

## Publish to a hub repository

To submit the skill to a hub repository via Hermes:

```bash
hermes skills publish /absolute/path/to/skills/hermes-omx-bridge --to github --repo <owner>/<hub-repo>
```

## Local validation

```bash
python3 - <<'PY'
from pathlib import Path
import yaml
p = Path('skills/hermes-omx-bridge/SKILL.md')
front = p.read_text().split('---', 2)[1]
data = yaml.safe_load(front)
assert data['name'] == 'hermes-omx-bridge'
assert 'description' in data
print('ok')
PY
```

To check that the skill is publish-safe before supplying a destination repo:

```bash
hermes skills publish "$PWD/skills/hermes-omx-bridge" --to github
```

Expected result: the scan completes without a dangerous verdict, then Hermes asks for `--repo`.

## Ask Codex or OMX to set it up

If you want Codex/OMX to help wire this into Hermes, paste the prompt in:

```text
helpers/codex-omx-hermes-integration.md
```

For a local check from this repository:

```bash
scripts/verify-hermes-omx-bridge.sh
```

To install the Hermes skill and run a disposable OMX smoke test:

```bash
scripts/verify-hermes-omx-bridge.sh --install --omx-smoke
```
