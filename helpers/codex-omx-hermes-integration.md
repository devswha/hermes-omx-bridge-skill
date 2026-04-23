# Codex/OMX Prompt: Help Me Integrate Hermes with OMX

Use this prompt when you are talking to Codex, OMX, or another coding agent and want it to set up or validate the Hermes ↔ OMX bridge.

```text
Task: Help me integrate Hermes Agent with oh-my-codex (OMX) using the Hermes OMX Bridge skill.

Goal:
- Make it possible for a chosen Hermes bot/profile to delegate coding, repo analysis, test/fix loops, and parallel execution to OMX.
- Verify the integration end-to-end enough that I can ask a Hermes bot/profile: "use OMX for <repo task>".

Skill source:
- GitHub tap/direct install: devswha/hermes-omx-bridge-skill/skills/hermes-omx-bridge
- Repo: https://github.com/devswha/hermes-omx-bridge-skill

Please do the following:
1. Check that `hermes`, `omx`, `git`, and `gh` are available where relevant.
2. Check GitHub authentication with `gh auth status` if GitHub access is needed.
3. Add the skill tap if it is not already present:
   `hermes skills tap add devswha/hermes-omx-bridge-skill`
4. Inspect the skill:
   `hermes skills inspect devswha/hermes-omx-bridge-skill/skills/hermes-omx-bridge`
5. Install the skill if it is not installed:
   `hermes skills install devswha/hermes-omx-bridge-skill/skills/hermes-omx-bridge`
6. Run a small disposable OMX smoke test:
   - create a temporary git repo
   - run `omx explore --prompt "Confirm README.md exists; do not edit files."`
   - optionally run `omx exec --high --full-auto` only inside that disposable repo to create one harmless file and verify its content
7. Tell me exactly how to ask my chosen Hermes bot/profile to use OMX.

Safety constraints:
- Do not publish, force-push, or modify production repositories unless I explicitly ask.
- Do not paste secrets or environment values into prompts.
- Preserve existing local changes.
- If a command needs credentials or a maintainer-only permission, report the exact blocker and the next human action.

Report back with:
- Hermes skill install status
- OMX smoke test result
- Commands run
- Any blockers
- A copy-paste user request I can send to a Hermes bot/profile
```

## Minimal request to a Hermes bot/profile after setup

```text
Use OMX for this repository task.
Repository: <repo-path>
Task: <goal>
Acceptance: <tests, lint, behavior, docs, or report expected>
Constraints: preserve existing work, avoid unrelated rewrites, no external publish unless asked.
Report back with changed files, verification evidence, and remaining risks.
```
