# Tidy

A shared filing memory for Claude Code and Codex.

Agents don't always need smarter models. Sometimes they need better memory.

Tidy is a Claude Code skill, a Codex slash prompt, and a local markdown wiki in `~/.tidy/`. Teach it once, and both agents can learn how you organize files.

## Demo

This is an abbreviated version of a real first run in Claude Code:

```text
User:
/tidy can you tidy up my Downloads folder? I am only interested in books

Tidy:
Found 7 loose epubs in ~/Downloads/. You already have ~/Downloads/Books/
with sci-fi/, fantasy/, nonfiction/, history/ subfolders.

Plan:
- 4 sci-fi -> ~/Downloads/Books/sci-fi/
- 3 nonfiction -> ~/Downloads/Books/nonfiction/

No existing book skill — if you say yes, I'll propose an ebook.md skill afterwards.
OK to move?

User:
ok, do it

Tidy:
Done. 7 ebooks moved and logged.

I'd like to capture this as ~/.tidy/skills/ebook.md so next time I can file
ebooks by genre from the approved rule. OK to write it?
```

After approval, Tidy wrote `skills/ebook.md` and updated `index.md`. The next ebook batch can be handled by reading that skill instead of rediscovering the pattern.

## Install

```bash
git clone https://github.com/robert-blaga/tidy
cd tidy
./install.sh
```

You need at least one of:

- **Claude Code** — `npm install -g @anthropic-ai/claude-code`, then `claude` once to sign in.
- **Codex** — `npm install -g @openai/codex`, then `codex login`.

## Use

In Claude Code:

```text
/tidy ~/Downloads
```

In Codex:

```text
/tidy ~/Downloads
```

Or just describe the scope:

```text
/tidy can you tidy up my Downloads folder? I am only interested in books
```

## How It Works

1. The agent reads `~/.tidy/index.md`.
2. It finds the approved skill that matches the files.
3. It reads and follows that skill.
4. It files the batch and logs what happened.
5. If no approved skill fits, it uses `when-nothing-fits.md`, asks before inventing new filing behavior, then proposes a new or updated skill.

The wiki is the durable part. Skills are executable memory. Claude Code and Codex are replaceable runtimes.

## What Gets Installed

- Claude Code skill: `~/.claude/skills/tidy/SKILL.md`
- Codex slash prompt: `~/.codex/prompts/tidy.md`
- Shared wiki: `~/.tidy/`

```text
~/.tidy/
├── AGENTS.md
├── index.md
├── skills/
│   ├── how-to-ask.md
│   ├── how-to-log.md
│   ├── how-to-update-the-wiki.md
│   ├── when-nothing-fits.md
│   └── ...
└── log/
    └── index.md
```

## Update And Check

Refresh repo-owned Tidy files without touching your learned skills, index, or logs:

```bash
git pull
./install.sh --update
```

Check your install:

```bash
./install.sh --doctor
```

## Why

Tidy came from two places: my computer was a mess, and Andrej Karpathy's [LLM Wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) crystallized the pattern. His gist describes the wiki as a persistent, compounding artifact maintained by an LLM instead of knowledge being rediscovered from scratch every session.

Tidy applies that idea to filing: the files are the mess, the wiki is the memory, and the agent does the bookkeeping. Thank you, Andrej.

## Docs

- [Teaching Tidy](docs/teaching.md)
- [Undo and Recovery](docs/recovery.md)
- [Runtime and Privacy](docs/runtime-and-privacy.md)
- [Philosophy](docs/philosophy.md)
- [Contributing](CONTRIBUTING.md)
- [Security](SECURITY.md)

## Status

v0.1.0. Small, useful, and early.

## Uninstall

```bash
rm -rf ~/.tidy ~/.claude/skills/tidy ~/.codex/prompts/tidy.md
```
