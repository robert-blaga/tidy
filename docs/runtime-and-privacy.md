# Runtime And Privacy

Tidy is plain markdown plus installed agent instructions. It does not run a service, connect to a backend, or add a security boundary.

What runs is whichever agent you point at the wiki: Claude Code or Codex. When you invoke `/tidy`, the agent reads `~/.tidy/` plus the folder you asked it to organize, and passes whatever it needs to its provider as part of the prompt — same as any other Claude Code or Codex session.

Claude Code and Codex also control tool permissions. Tidy tells the agent what workflow to follow; it is not a sandbox or permission layer.

## Supported Runtimes

- **Claude Code**: installed as a skill in `~/.claude/skills/tidy/SKILL.md`.
- **Codex**: installed as a skill in `~/.codex/skills/tidy/SKILL.md` for Codex CLI and the Codex app, plus a slash prompt in `~/.codex/prompts/tidy.md` for `/tidy`.

Both read and write the same `~/.tidy/` wiki. Their exact behavior may differ because they are different agents with different tool and approval flows, but the memory is shared.

The wiki is yours: read it, edit it, version-control it, share it.
