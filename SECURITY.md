# Security

Tidy is a skill/prompt plus a markdown wiki. It is not an app, daemon, sandbox, or permission boundary.

Claude Code or Codex execute actions, decide which tools require approval, and control what context is sent to their providers. Tidy's playbook tells the agent how to use `~/.tidy/` as filing memory; it does not add enforcement around the agent runtime.

The Tidy workflow is:

- if an approved skill matches, the agent follows it
- if no approved skill matches, the agent investigates, proposes a plan, and asks before inventing new filing behavior
- before changing `~/.tidy/skills/` or `~/.tidy/index.md`, the agent shows the exact markdown and asks for approval
- every run should be logged in `~/.tidy/log/`

Review your Claude Code or Codex permission and provider settings before using Tidy on sensitive files.
