# Contributing

Tidy is intentionally small: a Claude Code skill, a Codex slash prompt, and a markdown wiki template. The wiki is the durable part.

## Scope

Keep the core loop intact:

1. Read `~/.tidy/index.md`.
2. Find the approved skill.
3. Read the skill.
4. Follow it, file the batch, and log it.
5. If no approved skill fits, use `when-nothing-fits.md`, ask before inventing new filing behavior, then propose a wiki update.

Do not add an app, daemon, watcher, background service, runtime wrapper, or permission layer without discussing it first. Claude Code and Codex are the runtimes; Tidy is memory and method.

## Editing Guidelines

- Keep prompts short, direct, and operational.
- Preserve the distinction between approved skills and fallback learning.
- Never make `install.sh` overwrite user-owned files: `~/.tidy/index.md`, learned skills, and `~/.tidy/log/**`.
- Repo-owned files may be refreshed by `./install.sh --update`, with backups for local edits.
- Prefer plain markdown and standard macOS shell tools. Avoid dependencies.

## Checks

Before opening a PR, run:

```bash
bash -n install.sh
```

If you change install/update behavior, also test with a temporary home:

```bash
tmp="$(mktemp -d)"
HOME="$tmp" bash install.sh
HOME="$tmp" bash install.sh --update
```
