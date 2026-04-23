# Hermes OMX Bridge Skill

[English](README.md) | 한국어

Hermes 봇/프로필이 [oh-my-codex](https://github.com/devswha/oh-my-codex)(`omx`)에 코딩 작업, 저장소 분석, 테스트/수정 루프, 병렬 실행을 위임하도록 도와주는 Hermes Agent skill입니다.

## 하는 일

이 skill은 사용자가 선택한 Hermes 봇/프로필에게 “OMX를 사용해줘”라고 요청하는 흐름을 만듭니다. Hermes는 대화형 오케스트레이션을 담당하고, `omx`는 실제 코드 실행을 담당합니다.

- `omx explore`: 읽기 전용 저장소 조사
- `omx exec`: 일반 구현, 디버깅, 리팩터링, 테스트
- `omx ralph`: 완료 조건이 만족될 때까지 반복
- `omx team`: 독립 작업 병렬 실행
- `omx exec` 또는 `omx ralph` 기반 QA/test/fix 루프

핵심은 범위가 명확한 prompt, 로컬 repo 지침 준수, OMX 결과 재검증, 사용자에게 안전하게 보고하는 것입니다.

## Hermes에게 바로 던질 요청

Hermes, Codex, OMX, 또는 repo bot에게 아래 요청을 그대로 붙여 넣으면 됩니다.

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

## 설치 후 Hermes 봇/프로필에게 보낼 요청

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

## 설치

custom tap으로 설치:

```bash
hermes skills tap add devswha/hermes-omx-bridge-skill
hermes skills search hermes-omx-bridge
hermes skills install devswha/hermes-omx-bridge-skill/skills/hermes-omx-bridge
```

## 로컬 검증

기본 점검:

```bash
scripts/verify-hermes-omx-bridge.sh
```

설치 + disposable OMX smoke test:

```bash
scripts/verify-hermes-omx-bridge.sh --install --omx-smoke
```

## Codex/OMX에게 연동을 맡기기

Codex/OMX에게 아래 파일의 prompt를 그대로 주면 됩니다.

```text
helpers/codex-omx-hermes-integration.md
```

## 저장소 구조

```text
helpers/
└── codex-omx-hermes-integration.md
scripts/
└── verify-hermes-omx-bridge.sh
skills/
└── hermes-omx-bridge/
    └── SKILL.md
```

## 배포 전 점검

```bash
hermes skills publish "$PWD/skills/hermes-omx-bridge" --to github
```

예상 결과: scan이 dangerous verdict 없이 끝나고, `--repo`가 필요하다는 메시지가 나옵니다.
