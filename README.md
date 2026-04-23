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

## Give this repo to a bot

If you are talking to a repository bot, Codex, OMX, or another coding agent, you can paste this request and let it handle the integration:

```text
Repository: https://github.com/devswha/hermes-omx-bridge-skill

Please integrate Hermes Agent with oh-my-codex (OMX) using this repository.

Do the following:
1. Clone or inspect the repository.
2. Read `README.md`, `helpers/codex-omx-hermes-integration.md`, and `skills/hermes-omx-bridge/SKILL.md`.
3. Check that `hermes`, `omx`, and `git` are available. If GitHub access is needed, check `gh auth status`.
4. Add the Hermes skill tap if needed:
   `hermes skills tap add devswha/hermes-omx-bridge-skill`
5. Inspect and install the skill:
   `hermes skills inspect devswha/hermes-omx-bridge-skill/skills/hermes-omx-bridge`
   `hermes skills install devswha/hermes-omx-bridge-skill/skills/hermes-omx-bridge`
6. Run the repo helper if available:
   `scripts/verify-hermes-omx-bridge.sh --install --omx-smoke`
7. Report the installed skill status, OMX smoke-test result, any blockers, and the exact user request I should send to my chosen Hermes bot/profile.

Safety:
- Do not publish, force-push, or modify production repositories unless explicitly asked.
- Do not print or paste secrets.
- Preserve existing local changes.
```

After setup, ask your chosen Hermes bot/profile something like:

```text
Use OMX for this repository task.
Repository: <repo-path>
Task: <goal>
Acceptance: <tests, lint, behavior, docs, or report expected>
Constraints: preserve existing work, avoid unrelated rewrites, no external publish unless asked.
Report back with changed files, verification evidence, and remaining risks.
```


## 한국어 빠른 시작

Hermes에게 아래처럼 말하면 됩니다:

```text
이 레포를 사용해서 Hermes와 OMX 연동을 설치하고 검증해줘:
https://github.com/devswha/hermes-omx-bridge-skill

README의 "Give this repo to a bot" 절차를 따라줘.
설치 후에는 어떤 진행 모드로 할지 나에게 먼저 물어봐.
선택지는 최소한 다음을 포함해줘:
1. 조회만 하기: omx explore
2. 일반 구현/수정: omx exec
3. 완료될 때까지 반복: omx ralph
4. 병렬 작업: omx team
5. 테스트/수정 반복: omx exec 또는 omx ralph 기반 QA loop

각 모드의 장단점과 추천 모드를 짧게 설명하고, 내가 선택하면 그때 실행해.
```

설치가 끝난 뒤 원하는 Hermes 봇/프로필에게는 이렇게 요청하세요:

```text
OMX를 사용해서 이 저장소 작업을 진행해줘.
Repository: <repo-path>
Task: <목표>
Acceptance: <테스트, 린트, 동작, 문서 등 완료 기준>
Constraints: 기존 작업 보존, 관련 없는 재작성 금지, 요청 없는 외부 publish 금지.

먼저 어떤 모드로 진행할지 물어봐:
- explore: 읽기 전용 조사
- exec: 일반 구현/수정
- ralph: 완료까지 반복
- team: 독립 작업 병렬 처리
- QA loop: 테스트/수정 반복

내가 모드를 선택한 뒤 실행하고, 변경 파일/검증 결과/남은 리스크를 보고해줘.
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

```bash
hermes skills tap add devswha/hermes-omx-bridge-skill
hermes skills search hermes-omx-bridge
hermes skills install devswha/hermes-omx-bridge-skill/skills/hermes-omx-bridge
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
